require 'spec_helper'
require './lib/asendia'

RSpec.describe Asendia::VERSION do
  it 'is a string' do
    expect(subject).to be_kind_of(String)
  end
end
