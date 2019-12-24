require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  let(:user) { create(:user) }

  context 'GET /groups route' do
    context 'renders #index template' do
      before :each do
        sign_in user

        get groups_path
      end

      after :each do
        sign_out user
      end

      it { expect(response).to render_template(:index) }
    end
  end

  context 'GET /groups/new route' do
    context 'renders #new template' do
      before :each do
        sign_in user

        get new_group_path
      end

      after :each do
        sign_out user
      end

      it { expect(response).to render_template(:new) }
    end

    context 'create a Group' do
      before :each do
        sign_in user

        post '/groups', params: { group: attributes_for(:group) }
      end

      after :each do
        sign_out user
      end

      it { expect(response).to redirect_to(groups_url) }

      it 'redirects to the Group#index page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end

  context 'GET /groups/:id route' do
    let(:group) { create(:group, user_ids: user.id) }

    context 'renders #show template' do
      before :each do
        sign_in user

        get group_path(group.id)
      end

      after :each do
        sign_out user
      end

      it { expect(response).to render_template(:show) }
    end
  end

  context '/groups/:id/edit route' do
    let(:group) { create(:group, user_ids: user.id) }

    context 'renders #edit template' do
      before :each do
        sign_in user

        get edit_group_path(group.id)
      end

      after :each do
        sign_out user
      end

      it { expect(response).to render_template(:edit) }
    end

    context 'edit a Group name' do
      before :each do
        sign_in user

        put "/groups/#{group.id}", params: { group: {
          name: "$Texas",
          description: group.description,
        } }
      end

      after :each do
        sign_out user
      end

      it { expect(response).to redirect_to(groups_url) }
      it { expect(Group.find(group.id).name).to eq('$Texas') }

      it 'redirects to the Groups page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end

    context 'edit a Group description' do
      before :each do
        sign_in user

        put "/groups/#{group.id}", params: { group: {
          name: group.name,
          description: "$Texas",
        } }
      end

      after :each do
        sign_out user
      end

      it { expect(response).to redirect_to(groups_url) }
      it { expect(Group.find(group.id).description).to eq('$Texas') }

      it 'redirects to the Groups page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end

  context 'DELETE /groups/:id' do
    let(:group) { create(:group, user_ids: user.id) }

    context 'renders #index template' do
      before :each do
        sign_in user

        delete "/groups/#{group.id}"
      end

      after :each do
        sign_out user
      end

      it { expect(response).to redirect_to(groups_url) }

      it 'redirects to the Groups page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end

  context 'GET /groups/invitation' do
    let(:group) { create(:group, user_ids: user.id) }
    let!(:invited_user) { create(:user, invitation_group_id: group.id ) }

    context 'when the invitee is signed in' do
      before :each do
        User.generate_invitation_token!(invited_user)
        sign_in invited_user

        get groups_invitation_url, params: { invitation_group_token: invited_user.invitation_group_token }
      end

      after :each do
        sign_out invited_user
      end

      it { expect(response).to redirect_to("#{group_invitation_path(group.id)}?invitation_group_token=#{invited_user.invitation_group_token}") }
    end

    context 'when the invitee is not signed in' do
      before :each do
        get groups_invitation_url, params: { invitation_token: invited_user.invitation_token }
      end

      it { expect(response).to redirect_to(new_user_session_path) }
    end

    context 'when another user attempts to navigate to confirmation link' do
      describe 'renders correct template' do
        before :each do
          sign_in user

          get groups_invitation_url, params: { invitation_token: invited_user.invitation_token }
        end

        it { expect(response).to redirect_to(root_path) }
      end
    end
  end

  context 'GET /groups/:id/invitation' do
    let(:group) { create(:group, user_ids: user.id) }
    let!(:invited_user) { create(:user, invitation_group_id: group.id ) }

    context 'when another user attempts to navigate to confirmation link' do
      describe 'renders correct template' do
        before :each do
          sign_in user

          get group_invitation_url(group.id), params: { invitation_token: invited_user.invitation_token }
        end

        it { expect(response).to redirect_to(root_path) }
      end
    end

    context 'when the invitee is signed in' do
      before :each do
        User.generate_invitation_token!(invited_user)
        sign_in invited_user

        get group_invitation_url(group.id), params: { invitation_group_token: invited_user.invitation_group_token }
      end

      after :each do
        sign_out invited_user
      end

      it { expect(response).to render_template(:confirm_invitation) }
    end

    context 'when the invitee is not signed in' do
      before :each do
        get group_invitation_url(group.id), params: { invitation_token: invited_user.invitation_token }
      end

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  context 'POST /groups/invitation' do
    let!(:group) { create(:group, user_ids: user.id) }
    let!(:invited_user) { create(:user, :with_group_invitation, invitation_group_id: group.id ) }

    context 'when the invitee is signed in' do
      before :each do
        sign_in invited_user

        post group_invitation_url(
          group.id,
          invitation_group_token: invited_user.invitation_group_token
        )

        invited_user.reload
      end

      after :each do
        sign_out invited_user
      end

      it { expect(response).to redirect_to(group_path(group.id)) }
      it { expect(invited_user.invitation_group_id).to eq(nil) }
      it { expect(invited_user.invitation_group_token).to eq(nil) }
      it { expect(invited_user.invitation_sent_at).to eq(nil) }
    end

    context 'when another user attempts to confirm an invitation' do
      describe 'renders correct template' do
        before :each do
          sign_in user

          post group_invitation_url(
            group.id,
            invitation_group_token: invited_user.invitation_group_token
          )
        end

        it { expect(response).to redirect_to(root_path) }
      end
    end
  end

  context 'DELETE /groups/invitation' do
    let!(:group) { create(:group, user_ids: user.id) }
    let!(:invited_user) { create(:user, :with_group_invitation, invitation_group_id: group.id ) }

    context 'when the invitee is signed in' do
      before :each do
        sign_in invited_user

        delete group_invitation_path(group.id), params: {
          invitation_group_token: invited_user.invitation_group_token
        }

        invited_user.reload
      end

      after :each do
        sign_out invited_user
      end

      it { expect(response).to redirect_to(orders_path) }
      it { expect(invited_user.invitation_group_id).to eq(nil) }
      it { expect(invited_user.invitation_group_token).to eq(nil) }
      it { expect(invited_user.invitation_sent_at).to eq(nil) }
    end

    context 'when another user attempts to navigate to confirmation link' do
      describe 'renders correct template' do
        before :each do
          sign_in user

          delete group_invitation_path(group.id), params: {
            invitation_group_token: invited_user.invitation_group_token
          }
        end

        after :each do
          sign_out user
        end

        it { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
