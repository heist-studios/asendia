# Asendia

Ruby API wrapper for Asendia SOAP API

## Getting Started

Create an Asendia::Client object with your username and password:

```
  asendia = Asendia::Client.new(
    username: 'foo',
    password: 'bar',
    live:     Rails.env.production?
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
