require 'rails_helper'

RSpec.feature 'Group#destroy', js: true do
  context 'when editing a group' do
    let(:user) { create(:user) }
    let!(:group) { create(:group, name: '$Texas', user_ids: user.id) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'clicking destroy button' do
      before :each do
        visit groups_path

        accept_alert do
          click_button('Destroy')
        end
      end

      it { expect(page).to have_current_path(groups_path) }
      it { expect(page).to_not have_selector('.listItem-hd', text: '$Texas') }
    end
  end
end
