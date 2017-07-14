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

    def self.fetch(client, order_ids)
      response = client.call(
        :get_order,
        message: {
          OrderIDList: order_ids.join(',')
        }
      ).body

      response = response[:get_order_response][:get_order_return]
      response[:recordset][:record].map do |record|
        Shipment.new_from_api(record)
      end
    end

    def self.new_from_api(record)
      Shipment.new(
        id:              record[:orderid],
        delivery_method: record[:deliverymethod],
        dispatched:      record[:despatched] == 'Yes',
        dispatched_on:   Date.parse(record[:despatcheddate]),
        picking_status:  record[:pickingstatus].downcase,
        tracking_number: record[:trackno]
      )
    end
  end
end
