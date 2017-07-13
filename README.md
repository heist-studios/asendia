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

