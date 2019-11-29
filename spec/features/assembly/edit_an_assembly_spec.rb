require 'rails_helper'

RSpec.feature 'Edit an Assembly', js: true do
  let(:user) { create(:user) }
  let(:department) { create(:department, ownable: user) }
  let(:item1) { create(:item, department: department, ownable: user) }
  let(:item2) { create(:item, department: department, ownable: user) }
  let(:assembly) { create(:assembly, item_ids: [item1.id, item2.id], ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'updates a record' do
    before :each do
      visit edit_assembly_path(assembly.id)

      fill_in('Name', with: '$Texas')
      click_button('Update Assembly')
    end

    it { expect(page).to have_selector('.js-notice', text: 'Assembly was updated successfully') }
    it { expect(page).to have_text('$Texas') }
  end
end
