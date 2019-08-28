require 'rails_helper'

RSpec.feature 'Add assembly item to Order', js: true do
  let!(:pending_order) { create(:order, :pending) }
  let!(:assembly) { create(:assembly, :with_item) }

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
