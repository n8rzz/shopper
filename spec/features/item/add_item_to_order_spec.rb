require 'rails_helper'

RSpec.feature 'Add item to order', js: true do
  let(:user) { create(:user) }
  let(:department) { create(:department, ownable: user) }
  let!(:pending_order) { create(:order, :pending) }
  let!(:item) { create(:item, department: department, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit items_path

    within first('.listItem') do
      click_button 'Add to order'
    end
  end

  context 'displays notification of added Item' do
    it { expect(page).to have_text("#{item.name} added to order") }
  end

  context 'adds item to an order' do
    before :each do
      visit order_path(pending_order.id)
    end

    it { expect(page).to have_text(item.name) }
    it { expect(page).to_not have_text('Qty: 1') }
    it { expect(page).to have_text(item.department.name) }
  end
end
