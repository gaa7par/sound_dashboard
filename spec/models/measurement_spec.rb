require 'rails_helper'

RSpec.describe Measurement do
  it 'has valid factory' do
    expect(build(:measurement)).to be_valid
  end
end
