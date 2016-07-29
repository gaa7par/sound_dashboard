require 'rails_helper'

RSpec.describe Room do
  it 'has valid factory' do
    expect(build(:room)).to be_valid
  end
end
