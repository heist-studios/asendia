require 'savon'
require 'backport_dig'
require 'byebug'

module Asendia
  # Handles communication with Asendia API
  class Client
    WSDL_URL = 'https://reporting-rfc.asendia.co.uk/Heist/externalCom/webservice.cfc?wsdl'.freeze

    attr_reader :username, :password, :live

    def initialize(username:, password:, live: false)
      @username = username
      @password = password
      @live     = live
      @client   = Savon.client(wsdl: WSDL_URL)
    end

    def get_order(order_id)
      get_orders([order_id]).first
    end

    def get_orders(order_ids)
      Shipment.fetch(self, order_ids)
    end

    def get_product(product_id)
      get_products([product_id]).first
    end

    def get_products(product_ids)
      Product.fetch(self, product_ids)
    end

    def request(endpoint, params)
      # ReturnType 1 is XML, i.e. we want XML to be returned.
      params[:ReturnType] = 1
      params[:username] = @username
      params[:password] = @password

      @client.call(endpoint, message: params).body.dig(
        "#{endpoint}_response".to_sym,
        "#{endpoint}_return".to_sym,
        :recordset,
        :record
      )
    end
  end
end
