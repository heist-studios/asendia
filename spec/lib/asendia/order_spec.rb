require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Order do
  describe '#to_xml' do
    subject { FactoryGirl.build(:asendia_order).to_xml }

    it 'should always include <ArrayOfPurchaseOrder>' do
      expect(subject).to include '<ArrayOfPurchaseOrder>'
    end

    it 'should always have at least one <PurchaseOrder>' do
      expect(subject).to include '<PurchaseOrder>'
    end

    it 'should always set campaign to ImportOrder' do
      expect(subject).to include '<Campaign>ImportOrder</Campaign>'
    end

    it 'should always set CurrentState to Confirmed' do
      expect(subject).to include '<CurrentState>Confirmed</CurrentState>'
    end

    it 'should set empty currency fields to 0.0 rather than nil' do
      expect(subject).to include '<TaxAmount>0.0</TaxAmount>'
      expect(subject).to include '<DeliveryAmount>0.0</DeliveryAmount>'
    end
  end
end
