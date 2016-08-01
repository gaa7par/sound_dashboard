require 'rails_helper'

RSpec.describe Recorder do
  it 'has valid factory' do
    expect(build(:recorder)).to be_valid
  end
end
