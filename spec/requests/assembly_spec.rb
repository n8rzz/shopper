require 'rails_helper'

RSpec.describe 'Assembly', :type => :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_in user
  end

  context 'GET /assemblies route' do
    context 'renders #index template' do
      before :each do
        get assemblies_path
      end

      it { expect(response).to render_template(:index) }
    end
  end

  context 'GET /assemblies/new route' do
    context 'renders #new template' do
      before :each do
        get new_assembly_path
      end

      it { expect(response).to render_template(:new) }
    end
  end

  context 'POST create a Assembly' do
    before :each do
      post assemblies_path, :params => { :assembly => attributes_for(:assembly) }
    end

    it { expect(response).to redirect_to(assemblies_path) }

    it 'redirects to the Assemblys page' do
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end
end
