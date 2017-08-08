# Asendia

Ruby API wrapper for the Asendia SOAP API, version 1.5.

## Getting Started

Create an Asendia::Client object with your username and password:

```
  client = Asendia::Client.new(
    username:    'foo',
    password:    'bar',
    client_name: 'baz'
    live:        Rails.env.production?
  )
```

### Fetching order tracking information

```
  order = client.get_order('A123')
  orders = client.get_orders(['A123', 'B345'])

  puts order.picking_status
  puts order.tracking_number
```

### Fetching stock information

```
  products = client.get_products([123, 456])
  product = client.get_product(123)

  puts product.free_stock
```

### Creating a new order

```
  order = Asendia::Order.new(
    total_amount: '...',
    delivery_title: '...',
    delivery_forename: '...',
    ...
  )

  order.save(client)
```
