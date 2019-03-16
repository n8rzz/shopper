require 'rails_helper'

RSpec.describe AssemblyItem, type: :model do
  it 'has a valid factory' do
    expect(build(:assembly_item)).to be_instance_of(AssemblyItem)
  end

  describe 'data and associations' do
    it { should belong_to(:assembly) }
    it { should belong_to(:item) }
  end

  before do
    @assembly_item = build(:assembly_item)
  end

  subject { @assembly_item }

  describe 'validations' do
    it { should be_valid }
  end
end
