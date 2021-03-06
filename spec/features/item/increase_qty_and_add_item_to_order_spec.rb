require 'rails_helper'

RSpec.feature 'Increase qty and add Item to an order', js: true do
  let(:user) { create(:user) }
  let(:department) { create(:department, ownable: user) }
  let!(:order) { create(:order, :pending) }
  let!(:item) { create(:item, department: department, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit items_path

    within "div[data-stepper-id=\"#{item.id}\"]" do
      find(".js-stepper-btn-increase").click
      find(".js-stepper-btn-increase").click

      click_button 'Add to order'
    end
  end

  it { expect(find("#item-#{item.id}-qty")).to have_text('1') }

  scenario 'Displays correct qty on order#show' do
    visit order_path(order.id)

    expect(page).to have_text('Qty: 3')
    expect(page).to have_text(item.name)
    expect(page).to have_text(item.department.name)
  end
end
