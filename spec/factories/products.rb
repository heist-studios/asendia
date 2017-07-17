require 'factory_girl'

FactoryGirl.define do
  factory :asendia_product, class: 'Asendia::Product' do
    code           { FFaker::Product.model }
    description    { FFaker::Product.product }
    free_stock     50
    physical_stock 75
    reserved_stock 25
  end
end
