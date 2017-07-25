require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Client do
  describe '#get_order' do
    it 'returns shipment' do
      asendia = Asendia::Client.new(
        username:    ENV.fetch('ASENDIA_USERNAME'),
        password:    ENV.fetch('ASENDIA_PASSWORD'),
        client_name: ENV.fetch('ASENDIA_CLIENT_NAME'),
        live:        false
      )

      output = asendia.get_order(1_495_407)
      expect(output).to be_kind_of(Asendia::Shipment)
    end
  end

  describe '#get_product' do
    it 'returns array of products' do
      asendia = Asendia::Client.new(
        username:    ENV.fetch('ASENDIA_USERNAME'),
        password:    ENV.fetch('ASENDIA_PASSWORD'),
        client_name: ENV.fetch('ASENDIA_CLIENT_NAME'),
        live:        false
      )
      output = asendia.get_product(1_102_010_101)
      expect(output).to be_kind_of(Asendia::Product)
    end
  end
end
