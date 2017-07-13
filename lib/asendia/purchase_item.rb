module Asendia
  class PurchaseItem
    include Virtus.model

    attribute :created_by,            String
    attribute :created_on,            DateTime
    attribute :purchase_item_number,  Integer
    attribute :purchase_order_number, Integer
    attribute :product_code,          String
    attribute :line_number,           Integer
    attribute :product_name,          String
    attribute :product_price,         Money
    attribute :quantity,              Integer
  end
end
