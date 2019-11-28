require 'rails_helper'

RSpec.describe 'Department', :type => :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'GET /departments' do
    context 'renders #index template' do
      before :each do
        get '/departments'
      end

      it { expect(response).to render_template(:index) }
      it { expect(response).to_not render_template(:show) }
    end
  end

  context 'GET /departments/new' do
    context 'renders #new template' do
      before :each do
        get '/departments/new'
      end

      it { expect(response).to render_template(:new) }
    end

    context 'POST /departments' do
      before :each do
        post '/departments', :params => { :department => attributes_for(:department) }
      end

      it { expect(response).to redirect_to(departments_path) }

      it 'and redirects to the Department\'s page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end

    context 'PUT /departments' do
      let(:department) { create(:department, name: 'Honey Hole', ownable: user) }

      before :each do
        put department_path(department.id), :params => { :department => { name: 'Jackson Hole' }}
      end

      it { expect(response).to redirect_to(departments_path) }

      it 'and redirects to the Department\'s page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end

    context 'DELETE /departments' do
      let(:department) { create(:department, ownable: user) }

      before :each do
        delete department_path(department.id)
      end

      it { expect(response).to redirect_to(departments_path) }

      it 'and redirects to the Department\'s page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end
end
