require 'rails_helper'

RSpec.feature 'Group#confirm_invitation', js: true do
  context 'when invitee is not the #current_user' do
    let(:user) { create(:user) }
    let!(:group) { create(:group, name: '$Texas', user_ids: user.id) }
    let(:invited_user) { create(:user, invitation_group_id: group.id, invitation_group_token: 'threeve') }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    describe 'navigating to confirmation link' do
      before :each do
        visit "#{groups_invitation_path}?invitation_group_token=#{invited_user.invitation_group_token}"
      end

      it { expect(page).to have_current_path(root_path) }
    end
  end

  context 'when invitee is the #current_user' do
    let(:user) { create(:user) }
    let!(:group) { create(:group, name: '$Texas', user_ids: user.id) }
    let(:invited_user) { create(:user, invitation_group_id: group.id, invitation_group_token: 'threeve') }

    before :each do
      sign_in invited_user

      visit "#{group_invitation_path(group.id)}?invitation_group_token=#{invited_user.invitation_group_token}"
    end

    after :each do
      sign_out invited_user
    end

    describe ':confirm_invitation template' do
      it { expect(find('#invitation_group_id', visible: false).value).to eq(invited_user.invitation_group_id.to_s)}
      it { expect(find('#invitation_group_token', visible: false).value).to eq(invited_user.invitation_group_token)}
      it { expect(page).to have_selector('.link', text: 'Decline') }
      it { expect(page).to have_button('Accept') }
    end

    describe 'click on Decline' do
      before :each do
        accept_alert do
          click_link('Decline')
        end
      end

      it { expect(page).to have_current_path(orders_path) }
      it { expect(page).to have_selector('.js-notice', text: 'Group invite declined sucessfully') }
    end

    describe 'click on Accept' do
      before :each do
        click_button('Accept')
      end

      it { expect(page).to have_current_path(group_path(group.id)) }
      it { expect(page).to have_selector(
        '.js-notice',
        text: 'Group invite confirmed! We are transferring ownership of your items, assemblies, locations and departments'
      ) }
    end
  end
end
