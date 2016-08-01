require 'rails_helper'

RSpec.describe Admin do
  it 'has valid factory' do
    expect(build(:admin)).to be_valid
  end
end
