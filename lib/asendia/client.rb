require 'savon'

module Asendia
  # Handles communication with Asendia API
  class Client
    WSDL_URL = 'https://demo0884331.mockable.io/?wsdl'.freeze

    def initialize(username:, password:, live: false)
      @username = username
      @password = password
      @live     = live
      @client   = Savon.client(wsdl: WSDL_URL)
    end

    def get_order(order_id)
      get_orders([order_id])
    end

    def get_orders(order_ids)
      Shipment.fetch(@client, order_ids)
    end

    def get_product(product_id)
      get_products([product_id])
    end

    def get_products(product_ids)
      Product.fetch(@client, product_ids)
    end
  end
end
