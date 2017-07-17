require 'savon'
require 'backport_dig'
require 'byebug'

module Asendia
  # Handles communication with Asendia API
  class Client
    WSDL_URL = 'https://demo0884331.mockable.io/?wsdl'.freeze

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
      @client.call(endpoint, message: params).body.dig(
        "#{endpoint}_response".to_sym,
        "#{endpoint}_return".to_sym,
        :recordset,
        :record
      )
    end

    def post
    end
  end
end
