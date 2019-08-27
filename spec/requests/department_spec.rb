require 'rails_helper'

RSpec.describe 'Department', :type => :request do
  context '/departments route' do
    context 'renders #index template' do
      before :each do
        get '/departments'
      end

      it { expect(response).to render_template(:index) }
      it { expect(response).to_not render_template(:show) }
    end
  end

  context '/departments/new route' do
    context 'renders #new template' do
      before :each do
        get '/departments/new'
      end

      it { expect(response).to render_template(:new) }
      it { expect(response).to_not render_template(:show) }
    end

    context 'create a Department' do
      before :each do
        post '/departments', :params => { :department => attributes_for(:department) }
      end

      it { expect(response).to redirect_to(departments_path) }

      it 'and redirects to the Department\'s page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end
end
