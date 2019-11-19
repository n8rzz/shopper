require 'rails_helper'

RSpec.feature 'Add assembly to Order', js: true do
  let!(:pending_order) { create(:order, :pending) }
  let!(:assembly) { create(:assembly, :with_items) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit assemblies_path

    within first('.listItem') do
      click_button('Add to order')
    end
  end

  context 'adds assembly to an order' do
    it { expect(page).to have_text("#{assembly.name} added to order") }
  end

  context 'adds each item to pending_order' do
    before :each do
      visit order_path(pending_order.id)
    end

    it { expect(page).to have_text(assembly.name, count: 2) }
    it { expect(page).to have_text(assembly.items.first.name) }
    it { expect(page).to have_text(assembly.items.first.department.name) }
    it { expect(page).to have_text(assembly.items.second.name) }
    it { expect(page).to have_text(assembly.items.second.department.name) }
  end
end
