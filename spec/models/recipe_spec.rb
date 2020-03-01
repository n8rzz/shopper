# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'has valid factories' do
    it { expect(build(:recipe)).to be_instance_of(Recipe) }
    it { expect(build(:recipe, :ownable_group)).to be_instance_of(Recipe) }
    it { expect(build(:recipe, :ownable_user)).to be_instance_of(Recipe) }
    it { expect(build(:recipe, :with_assembly)).to be_instance_of(Recipe) }
    it { expect(build(:recipe, :without_name)).to be_instance_of(Recipe) }
    it { expect(build(:recipe, :with_recipe_instructions_attributes)).to be_instance_of(Recipe) }
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_db_column(:description) }
    it { should have_db_column(:prep_time) }
    it { should have_db_column(:cook_time) }
    it { should have_db_column(:yield_value) }
    it { should have_db_column(:yield_unit) }
    it { should accept_nested_attributes_for(:recipe_ingredients) }
    it { should accept_nested_attributes_for(:recipe_instructions) }
    it { should belong_to(:ownable) }
    it { should belong_to(:assembly).optional }
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:recipe_instructions) }
  end

  before do
    @recipe = build(:recipe)
  end

  subject { @recipe }

  describe 'validations' do
    it { should respond_to(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should be_valid }
  end

  describe 'validate name or assembly_id' do
    before do
      @recipe = build(:recipe)
      @recipe_with_assembly = build(:recipe, assembly_id: 1)
    end

    it { expect(@recipe).to be_valid }
    it { expect(@recipe_with_assembly).to be_valid }
    it { expect(build(:recipe, name: nil, assembly_id: nil)).to_not be_valid }
    # it { expect(build(:recipe, assembly_id: 1)).to_not be_valid }
  end

  describe '.display_name' do
    let(:user) { create(:user) }

    describe 'when an assembly_id is present' do
      let(:assembly) { create(:assembly, ownable: user) }
      let(:recipe) { build(:recipe, name: nil, ownable: user, assembly_id: assembly.id) }

      it { expect(recipe.display_name).to eq(assembly.name) }
    end

    describe 'when an assembly_id is not present' do
      let(:recipe) { build(:recipe, ownable: user) }

      it { expect(recipe.display_name).to eq(recipe.name) }
    end
  end
end
