require 'rails_helper'

RSpec.feature 'Add assembly item to Order', js: true do
  let(:user) { create(:user) }
  let(:department) { create(:department, ownable: user) }
  let(:item1) { create(:item, department: department, ownable: user) }
  let(:item2) { create(:item, name: Faker::Ancient.hero, department: department, ownable: user) }
  let!(:assembly) { create(:assembly, item_ids: [item1.id, item2.id], ownable: user) }
  let!(:pending_order) { create(:order, :pending) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit assemblies_path

    first('.listItem-hd > .hdg').click
    find("button[data-assembly-item-id=\"#{assembly.assembly_items.first.id}\"]").click
  end

  context 'adds item from an assembly to an order' do
    it { expect(page).to have_text("#{assembly.items.first.name} added to order") }
  end

  context 'added item appears in pending order' do
    before :each do
      visit order_path(pending_order.id)
    end

    it { expect(page).to have_text(assembly.name) }
    it { expect(page).to have_text(assembly.items.first.name) }
    it { expect(page).to have_text(assembly.items.first.department.name) }
  end
end
