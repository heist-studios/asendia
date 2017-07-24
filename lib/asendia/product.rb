require 'virtus'

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
      response = client.request(
        :get_stock_update,
        ProductIDList: product_ids.join(',')
      )

      response = [response] unless response.is_a?(Array)
      response.map { |record| Product.new_from_api(record) }
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
