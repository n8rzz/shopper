require 'rails_helper'

RSpec.describe Department, type: :model do
  it 'has a valid factory' do
    expect(build(:department)).to be_instance_of(Department)
  end
end
