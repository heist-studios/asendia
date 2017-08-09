require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Product do
  describe '.fetch' do
    let(:client) do
      Asendia::Client.new(
        username:    ENV.fetch('ASENDIA_USERNAME'),
        password:    ENV.fetch('ASENDIA_PASSWORD'),
        client_name: ENV.fetch('ASENDIA_CLIENT_NAME'),
        live:        false
      )
    end

    it 'should make a request to asendia' do
      expect(client).to receive(:request).with(
        :get_stock_update,
        ProductIDList: a_kind_of(String)
      ).and_return([])

      Asendia::Product.fetch(client, ['123'])
    end

    it 'should convert a single product into array' do
      expect(client).to receive(:request).with(
        :get_stock_update,
        ProductIDList: a_kind_of(String)
      ).and_return([{}])

      output = Asendia::Product.fetch(client, ['123'])
      expect(output).to be_kind_of(Array)
    end

    it 'should return array of products' do
      expect(client).to receive(:request).with(
        :get_stock_update,
        ProductIDList: a_kind_of(String)
      ).and_return([{}, {}])

      output = Asendia::Product.fetch(client, ['123'])
      expect(output).to be_kind_of(Array)
      expect(output.first).to be_kind_of(Asendia::Product)
    end
  end

  describe '.new_from_api' do
    let(:parameters) do
      {
        productcode:   '123',
        description:   'foo',
        freestock:     1,
        physicalstock: 2,
        reservedstock: 3
      }
    end

    subject { Asendia::Product.new_from_api(parameters) }

    it 'sets the product code' do
      expect(subject.code).to eq(parameters[:productcode])
    end

    it 'sets the description' do
      expect(subject.description).to eq(parameters[:description])
    end

    it 'sets the free_stock' do
      expect(subject.free_stock).to eq(parameters[:freestock])
    end

    it 'sets the physical_stock' do
      expect(subject.physical_stock).to eq(parameters[:physicalstock])
    end

    it 'sets the reserved_stock' do
      expect(subject.reserved_stock).to eq(parameters[:reservedstock])
    end
  end
end
