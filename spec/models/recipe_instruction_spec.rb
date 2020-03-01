# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeInstruction, type: :model do
  context 'has valid factories' do
    it { expect(build(:recipe_instruction)).to be_instance_of(RecipeInstruction) }
  end

  describe 'data and associations' do
    it { should have_db_column(:text) }
    it { should have_db_column(:sort_order) }
    it { should belong_to(:recipe) }
  end

  before do
    @recipe_instruction = build(:recipe_instruction)
  end

  subject { @recipe_instruction }

  describe 'validations' do
    it { should respond_to(:text) }
    it { should respond_to(:sort_order) }
    it { should validate_numericality_of(:sort_order).is_greater_than_or_equal_to(0) }
    it { should be_valid }
  end
end
