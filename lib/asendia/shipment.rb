module Asendia
  # Shipments are orders that have been accepted and can now be tracked. Whilst
  # still called orders in Asendia, they have a different set of attributes
  # for tracking.
  class Shipment
    include ::Virtus.model

    attribute :id,              Integer
    attribute :delivery_method, String
    attribute :dispatched,      Boolean
    attribute :dispatched_on,   Date
    attribute :picking_status,  String
    attribute :tracking_number, String
  end
end
