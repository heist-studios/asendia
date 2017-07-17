require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::Order do
  describe '#to_xml' do
    subject { FactoryGirl.build(:asendia_order).to_xml }

    it 'should be wrapped in <ArrayOfPurchaseOrder>' do
      expect(subject).to include '<ArrayOfPurchaseOrder>'
    end
  end
end
