module Asendia
  # Products are used for accessing stock levels.
  class Product
    include Virtus.model

    attribute :code,           String
    attribute :description,    String
    attribute :free_stock,     Integer
    attribute :physical_stock, Integer
    attribute :reserved_stock, Integer

    def self.fetch(client, product_ids)
      response = client.call(
        :get_stock_update,
        message: {
          ProductIDList: product_ids.join(',')
        }
      ).body

      response = response[:get_stock_update_response][:get_stock_update_return]
      response[:recordset][:record].map do |record|
        Product.new_from_api(record)
      end
    end

    def self.new_from_api(record)
      Product.new(
        code:           record[:productcode],
        description:    record[:description],
        free_stock:     record[:freestock],
        physical_stock: record[:physicalstock],
        reserved_stock: record[:reservedstock]
      )
    end
  end
end
