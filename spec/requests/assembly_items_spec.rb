require 'rails_helper'

RSpec.describe 'AssemblyItem', :type => :request do
  before do
    sign_in create(:user)
  end

  context 'creating an assembly without item_ids' do
    before do
      post '/assemblies', :params => { :assembly => {:name => 'Threeve'} }
    end

    it { expect(response).to redirect_to(assemblies_path) }

    it 'renders the :index template' do
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'includes a successful creation message' do
      follow_redirect!
      expect(response.body).to include('Assembly was created successfully')
    end
  end
end
