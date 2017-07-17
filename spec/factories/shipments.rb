require 'factory_girl'

FactoryGirl.define do
  factory :asendia_shipment, class: 'Asendia::Shipment' do
    id              123
    delivery_method 'RM1'
    dispatched      true
    dispatched_on   Date.today
    picking_status  'Completed'
    tracking_number 'ABC123DEF456'
  end
end
