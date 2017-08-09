require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Shipment do
  describe '.fetch' do
    let(:client) do
      Asendia::Client.new(
        username:    ENV.fetch('ASENDIA_USERNAME'),
        password:    ENV.fetch('ASENDIA_PASSWORD'),
        client_name: ENV.fetch('ASENDIA_CLIENT_NAME'),
        live:        false
      )
    end

    let(:shipment) do
      { pickingstatus: 'Open' }
    end

    it 'should make a request to asendia' do
      expect(client).to receive(:request).with(
        :get_order,
        OrderIDList: a_kind_of(String)
      ).and_return([])

      Asendia::Shipment.fetch(client, ['123'])
    end

    it 'should convert a single shipment into array' do
      expect(client).to receive(:request).with(
        :get_order,
        OrderIDList: a_kind_of(String)
      ).and_return([shipment])

      output = Asendia::Shipment.fetch(client, ['123'])
      expect(output).to be_kind_of(Array)
    end

    it 'should return array of shipments' do
      expect(client).to receive(:request).with(
        :get_order,
        OrderIDList: a_kind_of(String)
      ).and_return([shipment, shipment])

      output = Asendia::Shipment.fetch(client, ['123'])
      expect(output).to be_kind_of(Array)
      expect(output.first).to be_kind_of(Asendia::Shipment)
    end
  end

  describe '.new_from_api' do
    let(:parameters) do
      {
        orderid:        100,
        deliverymethod: 'DPD',
        despatched:     'Yes',
        despatcheddate: '2015-01-01',
        pickingstatus:  'Open',
        trackno:        'ABC-123-DEF-456'
      }
    end

    subject { Asendia::Shipment.new_from_api(parameters) }

    it 'sets the id' do
      expect(subject.id).to eq(parameters[:orderid])
    end

    it 'sets the delivery_method' do
      expect(subject.delivery_method).to eq(parameters[:deliverymethod])
    end

    it 'sets as dispatched' do
      expect(subject).to be_dispatched
    end

    it 'sets the dispatched_on' do
      expect(subject.dispatched_on).to eq(Date.new(2015, 1, 1))
    end

    it 'sets the picking_status' do
      expect(subject.picking_status).to eq('open')
    end

    it 'sets the tracking_number' do
      expect(subject.tracking_number).to eq(parameters[:trackno])
    end
  end
end
