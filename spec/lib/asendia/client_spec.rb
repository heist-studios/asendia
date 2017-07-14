require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Client do
  describe '#get_order' do
    it 'returns a shipment' do
      asendia = Asendia::Client.new(
        username: 'foo',
        password: 'bar',
        live:     false
      )

      puts asendia.get_order(123).inspect
    end
  end

  describe '#get_product' do
    it 'returns array of products' do
      asendia = Asendia::Client.new(
        username: 'foo',
        password: 'bar',
        live:     false
      )

      asendia.get_product(123)
    end
  end
end
