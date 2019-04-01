require 'rails_helper'

RSpec.feature 'View an order' do
  let!(:order) { create(:order, :pending) }

  describe 'order#show' do
    before :each do
      visit order_path(order.id)
    end

    it { expect(page).to have_link('Back') }
    it { expect(page).to have_link('Edit') }
    it { expect(page).to have_link('Destroy') }
    it { expect(page).to have_link('Item') }
    it { expect(page).to have_link('Department') }
    it { expect(page).to have_link('Meal') }
    it { expect(page).to have_text("Shopping Date: #{order.order_date}") }
    it { expect(page).to have_text("Status: #{order.status}") }
  end
end
