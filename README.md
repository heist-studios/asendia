# Asendia UK / Europe

Ruby API wrapper for the Asendia SOAP API, version 1.5.

For more information on the API itself,
[check out the official documentation](/docs/api-v1.5.pdf)

## Installation

Install the gem by adding the following to your Gemfile and then running
`bundle install`.

```
gem 'asendia', git: 'git@github.com:heist-studios/asendia.git'
```

## Getting Started

First of all, you'll need to create an Asendia::Client object with your username
and password. It's highly recommended that you don't include the username and
password within your repo, but instead use environmental variables. To make
it easier to set these variables, we recommend using
[dotenv](https://github.com/bkeepers/dotenv) or similar.

```
  client = Asendia::Client.new(
    username:    ENV['ASENDIA_USERNAME'],
    password:    ENV['ASENDIA_PASSWORD'],
    client_name: ENV['ASENDIA_CLIENT_NAME'],
    live:        Rails.env.production?
  )
```

The client holds your authentication details and is used whenever a request is
made.

### Fetching order tracking information

We've created another object called a Shipment to encapsulate all of the
information that Asendia sends back about an order. The reason we didn't just
use the existing Order object is because the set of fields are completely
different.

```
  shipment = client.get_order('A123')
  shipments = client.get_orders(['A123', 'B345'])

  puts shipment.id               # Order ID
  puts shipment.delivery_method  # Delivery courier used to send the order
  puts shipment.dispatched?      # Whether the order has been dispatched yet
  puts shipment.dispatched_on    # Date that the order was shipped
  puts shipment.picking_status   # If set to 'completed', the order has been
                                 # picked and will either be dispatched or
                                 # awaiting dispatch.
  puts shipment.tracking_number  # Tracking code if you used a courier that
                                 # supports tracking.
```

### Fetching stock information

```
  products = client.get_products([123, 456])
  product = client.get_product(123)

  puts product.code            # The product ID
  puts product.description     # Product description which you set
  puts product.free_stock      # Amount of stock that can be bought
  puts product.physical_stock  # Total amount of stock actually in the warehouse
  puts product.reserved_stock  # Amount of stock that has been bought and is
                               # yet to ship
```

### Creating an order

You need to pass in a lot of data in order to create an order.

```
  order = Asendia::Order.new(
    created_by:        'Acme Company Ltd',
    created_on:        Date.today,
    amended_by:        'Acme Company Ltd',
    amended_on:        Date.today,
    contact_number:    '', # This is a customer reference number
                           # NOT a telephone number
    title:             'Mr',
    forename:          'Joe',
    surname:           'Bloggs',
    email:             'jbloggs@example.com',
    phone:             '0123 456 7890',
    currency:          'GBP',
    order_id:          'YOUR_ORDER_ID,
    total_amount:      12.34,
    delivery_title:    'Mr',
    delivery_forename: 'Joe',
    delivery_surname:  'Bloggs',
    delivery_address:  '123 Some Road',
    delivery_address2: 'Somewhere',
    delivery_address3: '',
    delivery_town:     'Some City',
    delivery_county:   'Some Region',
    delivery_postcode: 'A1 2BC',
    delivery_country:  'GB', # ISO ALPHA-2 Country Code
    ship_method:       'DPD_24' # You'll need to speak with your Asendia
                                # account manager to get the options for this.
  )
```

But that's not all. You also need to create the line items (or as Asendia calls
them, PurchaseItems).

```
  order.purchase_items << ::Asendia::PurchaseItem.new(
    created_by:            'Acme Company Ltd',
    created_on:            Date.today,
    purchase_item_number:  'YOUR_LINE_ITEM_ID',
    purchase_order_number: 'YOUR_ORDER_ID',
    product_code:          'SKU123',
    line_number:           1, # Optional - it's used to order the line items.
    product_name:          'Bronze Widget',
    product_price:         6.17,
    quantity:              2
  )
```

Finally you can save with the following:

```
order.save(client)
```
