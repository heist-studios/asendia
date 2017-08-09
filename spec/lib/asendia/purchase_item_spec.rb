require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::PurchaseItem do
  describe '#to_xml' do
    subject do
      build(
        :asendia_purchase_item,
        created_on: Date.new(2015, 01, 01)
      )
    end

    let(:builder) do
      Nokogiri::XML::Builder.new do |xml|
        xml.PurchaseItems do
          subject.to_xml(xml)
        end
      end
    end

    it 'sets CreatedBy' do
      expect(builder.to_xml).to include(
        '<CreatedBy>Foo Bar</CreatedBy>'
      )
    end

    it 'sets CreatedOn' do
      expect(builder.to_xml).to include(
        '<CreatedOn>2015-01-01T00:00:00+00:00</CreatedOn>'
      )
    end

    it 'sets PurchaseItemNumber' do
      expect(builder.to_xml).to include(
        '<PurchaseItemNumber>1</PurchaseItemNumber>'
      )
    end

    it 'sets PurchaseOrderNumber' do
      expect(builder.to_xml).to include(
        '<PurchaseOrderNumber>1</PurchaseOrderNumber>'
      )
    end

    it 'sets ProductCode' do
      expect(builder.to_xml).to include(
        '<ProductCode>1</ProductCode>'
      )
    end

    it 'sets LineNumber' do
      expect(builder.to_xml).to include(
        '<LineNumber>1</LineNumber>'
      )
    end

    it 'sets ProductName' do
      expect(builder.to_xml).to include(
        '<ProductName>Product Name</ProductName>'
      )
    end

    it 'sets ProductPrice' do
      expect(builder.to_xml).to include(
        '<ProductPrice>10.00</ProductPrice>'
      )
    end

    it 'sets Quantity' do
      expect(builder.to_xml).to include(
        '<Quantity>1</Quantity>'
      )
    end
  end
end
