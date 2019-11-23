require 'rails_helper'

RSpec.describe "Groups", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'GET /groups route' do
    context 'renders #index template' do
      before :each do
        get groups_path
      end

      it { expect(response).to render_template(:index) }
    end
  end

  context 'GET /groups/new route' do
    context 'renders #new template' do
      before :each do
        get new_group_path
      end

      it { expect(response).to render_template(:new) }
    end

    context 'create a Group' do
      before :each do
        post "/groups", :params => { :group => attributes_for(:group) }
      end

      it { expect(response).to redirect_to(groups_url) }

      it "redirects to the Group#index page" do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end

  context 'GET /groups/:id route' do
    let(:group) { create(:group, user_ids: user.id) }

    context 'renders #show template' do
      before :each do
        get group_path(group.id)
      end

      it { expect(response).to render_template(:show) }
    end
  end

  context '/groups/:id/edit route' do
    let(:group) { create(:group, user_ids: user.id) }

    context 'renders #edit template' do
      before :each do
        get edit_group_path(group.id)
      end

      it { expect(response).to render_template(:edit) }
    end

    context 'edit a Group name' do
      before :each do
        put "/groups/#{group.id}", :params => { :group => {
          name: "$Texas",
          description: group.description,
        } }
      end

      it { expect(response).to redirect_to(groups_url) }
      it { expect(Group.find(group.id).name).to eq('$Texas') }

      it "redirects to the Groups page" do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end

    context 'edit a Group description' do
      before :each do
        put "/groups/#{group.id}", :params => { :group => {
          name: group.name,
          description: "$Texas",
        } }
      end

      it { expect(response).to redirect_to(groups_url) }
      it { expect(Group.find(group.id).description).to eq('$Texas') }

      it "redirects to the Groups page" do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end

  context 'DELETE /groups/:id' do
    let(:group) { create(:group, user_ids: user.id) }

    context 'renders #index template' do
      before :each do
        delete "/groups/#{group.id}"
      end

      it { expect(response).to redirect_to(groups_url) }

      it "redirects to the Groups page" do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end
end
