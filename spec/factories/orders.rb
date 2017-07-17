require 'factory_girl'
require 'money'
require 'ffaker'

FactoryGirl.define do
  factory :asendia_order, class: 'Asendia::Order' do
    created_by            'AcmeCompany'
    created_on            Date.today
    amended_by            'AcmeCompany'
    amended_on            Date.today

    # Authentication
    user_id               'username'
    password              'password'
    contact_number        '123'

    order_id              1
    title                 FFaker::Name.female_prefix
    forename              FFaker::Name.first_name_female
    surname               FFaker::Name.last_name
    company               ''
    email                 FFaker::Internet.email
    phone                 FFaker::PhoneNumber.phone_number
    currency              'GBP'
    total_amount          { Money.new(rand(20..150) * 100) }
    is_test               true

    # Delivery address
    delivery_title        FFaker::Name.female_prefix
    delivery_forename     FFaker::Name.first_name_female
    delivery_surname      FFaker::Name.last_name
    delivery_company      ''
    delivery_address      FFaker::AddressUK.secondary_address
    delivery_address2     FFaker::AddressUK.street_address
    delivery_address3     ''
    delivery_town         FFaker::AddressUK.city
    delivery_county       FFaker::AddressUK.county
    delivery_postcode     FFaker::AddressUK.postcode
    delivery_country      FFaker::AddressUK.country
    delivery_message      ''

    # Shipping
    ship_method           'DPD_24'

    # Line items
    purchase_items        { [FactoryGirl.build(:asendia_purchase_item)] }
  end
end
