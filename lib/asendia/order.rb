module Asendia
  class Order
    include Virtus.model

    attribute :created_by,            String
    attribute :created_on,            DateTime
    attribute :amended_by,            String
    attribute :amended_on,            DateTime
    attribute :campaign,              String

    # Authentication
    attribute :user_id,               String
    attribute :password,              String

    attribute :contact_number,        String
    attribute :title,                 String
    attribute :forename,              String
    attribute :surname,               String
    attribute :company,               String
    attribute :email,                 String
    attribute :phone,                 String
    attribute :currency,              String
    attribute :current_state,         String
    attribute :purchase_order_number, Integer
    attribute :is_gift,               Boolean
    attribute :tax_amount,            Money
    attribute :delivery_amount,       Money
    attribute :total_amount,          Money
    attribute :is_test,               Boolean

    # Delivery address
    attribute :delivery_title,        String
    attribute :delivery_forename,     String
    attribute :delivery_surname,      String
    attribute :delivery_company,      String
    attribute :delivery_address,      String
    attribute :delivery_address2,     String
    attribute :delivery_address3,     String
    attribute :delivery_town,         String
    attribute :delivery_county,       String
    attribute :delivery_postcode,     String
    attribute :delivery_country,      String
    attribute :delivery_message,      String

    # Billing address
    attribute :billing_address,       String
    attribute :billing_address2,      String
    attribute :billing_address3,      String
    attribute :billing_town,          String
    attribute :billing_county,        String
    attribute :billing_postcode,      String
    attribute :billing_country,       String

    # Shipping
    attribute :ship_method,           String

    # Line items
    attribute :purchase_items,        Array[PurchaseItem]
  end
end
