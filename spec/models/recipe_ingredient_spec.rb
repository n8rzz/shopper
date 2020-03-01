# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  context 'has valid factories' do
    it { expect(build(:recipe_ingredient)).to be_instance_of(RecipeIngredient) }
  end

  describe 'data and associations' do
    it { should have_db_column(:qty_unit) }
    it { should have_db_column(:qty_value) }
    it { should have_db_column(:name) }
    it { should belong_to(:recipe) }
    it { should belong_to(:item).optional(true) }
  end

  before do
    @recipe_ingredient = build(:recipe_ingredient)
  end

  subject { @recipe_ingredient }

  describe 'validations' do
    it { should respond_to(:qty_unit) }
    it { should respond_to(:qty_value) }
    it { should respond_to(:name) }
    it { should validate_presence_of(:qty_unit) }
    it { should validate_presence_of(:qty_value) }
    it { should be_valid }
  end

  describe 'validate name or item_id' do
    before do
      @recipe_ingredient = build(:recipe_ingredient)
      @recipe_ingredient_with_item = build(:recipe_ingredient, item_id: 1)
    end

    it { expect(@recipe_ingredient).to be_valid }
    it { expect(@recipe_ingredient_with_item).to be_valid }
    it { expect(build(:recipe_ingredient, name: nil, item_id: nil)).to_not be_valid }
    # it { expect(build(:recipe_ingredient, assembly_id: 1)).to_not be_valid }
  end
end
