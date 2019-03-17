require 'rails_helper'

RSpec.describe 'AssemblyItem ', :type => :request do
  let(:item) { create(:item) }

  context 'when creating an assembly without an item' do
    before do
      post '/assemblies', :params => { :assembly => {:name => 'Threeve'} }
    end

    it 're-renders the edit template' do
      expect(response).to render_template(:new)
    end
  end

  # it 'creates a Widget and redirects to the Widget\'s page' do
  #   get '/widgets/new'
  #   expect(response).to render_template(:new)

  #   post '/widgets', :params => { :widget => {:name => 'My Widget'} }

  #   expect(response).to redirect_to(assigns(:widget))
  #   follow_redirect!

  #   expect(response).to render_template(:show)
  #   expect(response.body).to include('Widget was successfully created.')
  # end

  # it 'does not render a different template' do
  #   get '/widgets/new'
  #   expect(response).to_not render_template(:show)
  # end
end
