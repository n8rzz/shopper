require 'rails_helper'

RSpec.describe 'AssemblyItem', :type => :request do
  let(:item) { create(:item) }

  context 'creating an assembly without item_ids' do
    before do
      post '/assemblies', :params => { :assembly => {:name => 'Threeve'} }
    end

    it 're-renders the edit template' do
      expect(response).to redirect_to(assigns(:assembly))
    end

    it 'renders the :show template' do
      follow_redirect!
      expect(response).to render_template(:show)
    end

    it 'includes a successful creation message' do
      follow_redirect!
      expect(response.body).to include('Assembly was created successfully')
    end
  end
end
