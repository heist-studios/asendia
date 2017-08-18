require 'virtus'

module Asendia
  # Shipments are orders that have been accepted and can now be tracked. Whilst
  # still called orders in Asendia, they have a different set of attributes
  # for tracking.
  class Shipment
    include Virtus.model

    attribute :id,              Integer
    attribute :delivery_method, String
    attribute :dispatched,      Boolean
    attribute :dispatched_on,   Date
    attribute :picking_status,  String
    attribute :tracking_number, String
    attribute :tracking_url,    String

    def dispatched?
      if dispatched && dispatched_on.nil?
        STDERR.puts "DESPATCHED set without DESPATCHEDDATE (shipment ID: #{id})"
      end

      if dispatched_on && !dispatched
        STDERR.puts "DESPATCHEDDATE set without DESPATCHED (shipment ID: #{id})"
      end

      dispatched && !!dispatched_on
    end

    def self.fetch(client, order_ids)
      response = client.request(
        :get_order,
        OrderIDList: order_ids.join(',')
      )

      response = [response] unless response.is_a?(Array)
      response.map { |record| Shipment.new_from_api(record) }
    end

    def self.new_from_api(record)
      dispatch_date = record[:despatcheddate]
      dispatch_date = Date.parse(dispatch_date) unless dispatch_date.nil?

      Shipment.new(
        id:              record[:orderid],
        delivery_method: record[:deliverymethod],
        dispatched:      record[:despatched] == 'Yes',
        dispatched_on:   dispatch_date,
        picking_status:  record[:pickingstatus].downcase,
        tracking_number: record[:trackno],
        tracking_url:    parse_tracking_link(record[:tracknolink])
      )
    end

    def self.parse_tracking_link(link)
      return nil if link.blank?
      Nokogiri::XML.parse("<xml>#{link}</xml>").content
    end
  end
end
