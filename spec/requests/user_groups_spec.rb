require 'rails_helper'

RSpec.describe 'UserGRoups', :type => :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:group) { create(:group, user_ids: [user.id, user2.id]) }

  before do
    sign_in user
  end

  after do
    sign_in user
  end

  context 'DELETE /groups/:id/members/:member_id route' do
    before :each do
      delete "/groups/#{group.id}/members/#{user2.id}"
    end

    it { expect(response).to redirect_to(group_path(group.id)) }

    it 'and renders correct template' do
      follow_redirect!

      expect(response).to render_template(:show)
    end
  end
end


