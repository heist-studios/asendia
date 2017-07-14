require 'nokogiri'

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

    # Shipping
    attribute :ship_method,           String

    # Line items
    attribute :purchase_items,        Array[PurchaseItem]

    def save
      puts to_xml.inspect
    end

    def to_xml
      Nokogiri::XML::Builder.new do |xml|
        xml.ArrayOfPurchaseOrder do
          xml.PurchaseOrder do
            xml.CreatedBy created_by
            xml.PurchaseItems do
              purchase_items.each do |item|
                xml.PurchaseItem { item.to_xml(xml) }
              end
            end
          end
        end
      end.to_xml
    end
  end
end
