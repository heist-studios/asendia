require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Client do
  describe '#get_orders' do
    it 'returns shipment' do
      asendia = Asendia::Client.new(
        username: 'foo',
        password: 'bar',
        live:     false
      )

      output = asendia.get_orders([123])
      expect(output).to be_kind_of(Array)
      expect(output.first).to be_kind_of(Asendia::Shipment)
    end
  end

  describe '#get_products' do
    it 'returns array of products' do
      asendia = Asendia::Client.new(
        username: 'foo',
        password: 'bar',
        live:     false
      )
      output = asendia.get_products([123])
      expect(output).to be_kind_of(Array)
      expect(output.first).to be_kind_of(Asendia::Product)
    end
  end
end
