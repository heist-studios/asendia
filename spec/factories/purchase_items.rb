require 'factory_girl'
require 'money'

FactoryGirl.define do
  factory :asendia_purchase_item, class: 'Asendia::PurchaseItem' do
    created_by            'Foo Bar'
    created_on            Date.today
    purchase_item_number  1
    purchase_order_number 1
    product_code          1
    line_number           1
    product_name          'Product Name'
    product_price         { Money.new(1000) }
    quantity              1
  end
end
