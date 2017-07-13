module Asendia
  # Handles communication with Asendia API
  class Client
    def initialize(username:, password:, live: false)
      @username = username
      @password = password
      @live     = live
    end

    # def get_order(order_id)
    # end

    # def get_stock_update(order_ids)
    # end

    # def create_order(attributes)
    # end
  end
end
