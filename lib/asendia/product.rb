module Asendia
  # Products are used for accessing stock levels.
  class Product
    include ::Virtus.model

    attribute :code,           String
    attribute :description,    String
    attribute :free_stock,     Integer
    attribute :physical_stock, Integer
    attribute :reserved_stock, Integer
  end
end
