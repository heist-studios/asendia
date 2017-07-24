require 'virtus'
require 'money'
require 'nokogiri'

module Asendia
  class Order
    include Virtus.model

    API_URL = 'https://data-rfc.asendia.co.uk/[USERNAME]/externalcom/' +
              'AddXMLOrder.cfm?ClientSys=[USERNAME]'.freeze

    attribute :created_by,            String
    attribute :created_on,            DateTime
    attribute :amended_by,            String
    attribute :amended_on,            DateTime

    # Authentication
    attribute :username,              String
    attribute :password,              String
    attribute :contact_number,        String

    attribute :order_id,              Integer
    attribute :title,                 String
    attribute :forename,              String
    attribute :surname,               String
    attribute :email,                 String
    attribute :phone,                 String
    attribute :currency,              String
    attribute :total_amount,          Money
    attribute :is_test,               Boolean

    # Delivery address
    attribute :delivery_title,        String
    attribute :delivery_forename,     String
    attribute :delivery_surname,      String
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

    def save(client)
      self.is_test = !client.live
      self.username = client.username
      self.password = client.password

      HTTParty.post(API_URL.gsub('[USERNAME]', client.username), body: to_xml)
    end

    def to_xml
      Nokogiri::XML::Builder.new do |xml|
        xml.ArrayOfPurchaseOrder do
          xml.PurchaseOrder do
            xml.CreatedBy           created_by
            xml.CreatedOn           created_on
            xml.AmendedBy           amended_by
            xml.AmendedOn           amended_on
            xml.Campaign            'ImportOrder'

            xml.UserId              username
            xml.Password            password
            xml.ContactNumber       contact_number

            xml.Title               title
            xml.Forename            forename
            xml.Surname             surname
            xml.Company             ''
            xml.Email               email
            xml.Phone               phone
            xml.Currency            currency

            xml.CurrentState        'Confirmed'
            xml.PurchaseOrderNumber order_id

            xml.TaxAmount           0.0
            xml.DeliveryAmount      0.0
            xml.TotalAmount         total_amount

            xml.IsTest              is_test

            xml.DeliveryTitle       delivery_title
            xml.DeliveryForename    delivery_forename
            xml.DeliverySurname     delivery_surname
            xml.DeliveryCompany     ''
            xml.DeliveryAddress     delivery_address
            xml.DeliveryAddress2    delivery_address2
            xml.DeliveryAddress3    delivery_address3
            xml.DeliveryTown        delivery_town
            xml.DeliveryCounty      delivery_county
            xml.DeliveryPostcode    delivery_postcode
            xml.DeliveryCountry     delivery_country
            xml.DeliveryMessage     delivery_message || ''

            xml.BillingAddress      delivery_address
            xml.BillingAddress2     delivery_address2
            xml.BillingAddress3     delivery_address3
            xml.BillingTown         delivery_town
            xml.BillingCounty       delivery_county
            xml.BillingPostcode     delivery_postcode
            xml.BillingCountry      delivery_country

            xml.ShipMethod          ship_method

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
