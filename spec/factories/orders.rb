FactoryGirl.define do
  factory :asendia_order, class: 'Asendia::Order' do
    created_by            'Foo Bar'
    created_on            Date.today
    amended_by            'Foo Bar'
    amended_on            Date.today
    campaign              'Foo'

    # Authentication
    user_id               'username'
    password              'password'
    contact_number        '123'

    title                 'Mr'
    forename              'Joe'
    surname               'Bloggs'
    company               ''
    email                 'foo@foo.com'
    phone                 '01234567890'
    currency              'GBP'
    current_state         'Confirmed'
    purchase_order_number 1
    is_gift               false
    tax_amount            { Money.new(0) }
    delivery_amount       { Money.new(0) }
    total_amount          { Money.new(2000) }
    is_test               true

    # Delivery address
    delivery_title        'Mr'
    delivery_forename     'Joe'
    delivery_surname      'Bloggs'
    delivery_company      ''
    delivery_address      '123 Some Road'
    delivery_address2     ''
    delivery_address3     ''
    delivery_town         'Some Town'
    delivery_county       'Some County'
    delivery_postcode     'A1 2BC'
    delivery_country      'United Kingdom'
    delivery_message      ''

    # Shipping
    ship_method           'DPD_24'

    # Line items
    purchase_items        { [FactoryGirl.build(:asendia_purchase_item)] }
  end
end
