require 'virtus'
require 'money'

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

    def to_xml(builder)
      builder.CreatedBy           created_by
      builder.CreatedOn           created_on
      builder.PurchaseItemNumber  purchase_item_number
      builder.PurchaseOrderNumber purchase_order_number
      builder.ProductCode         product_code
      builder.LineNumber          line_number
      builder.ProductName         product_name
      builder.ProductPrice        product_price
      builder.Quantity            quantity
    end
  end
end
