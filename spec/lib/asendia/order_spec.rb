require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Order do
  describe '#to_xml' do
    subject do
      Asendia::Order.new(
        created_by: 'foo',
        purchase_items: [
          Asendia::PurchaseItem.new(
            created_by: 'foobar',
            created_on: Date.today,
            purchase_item_number: '123'
          )
        ]
      )
    end

    let(:output) { subject.to_xml }

    it 'should contain created_by' do
      expect(output).to include '<CreatedBy>foo</CreatedBy>'
    end
  end
end
