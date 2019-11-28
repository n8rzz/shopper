require 'rails_helper'

RSpec.describe 'Item', :type => :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'GET /items' do
    context 'renders #index template' do
      before :each do
        get items_path
      end

      it { expect(response).to render_template(:index) }
      it { expect(response).to_not render_template(:show) }
    end
  end

  context 'GET /items/new' do
    context 'renders #new template' do
      before :each do
        get new_item_path
      end

      it { expect(response).to render_template(:new) }
    end
  end

  context 'POST /items' do
    let(:department) { create(:department, ownable: user) }

    before :each do
      post items_path, :params => { :item => attributes_for(:item, department_id: department.id) }
    end

    it { expect(response).to redirect_to(items_path) }

    it 'and redirects to the Item\'s page' do
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end

  context 'PUT /items' do
    let(:item) { create(:item, name: 'Honey Hole', ownable: user) }

    before :each do
      put item_path(item.id), :params => { :item => { name: 'Jackson Hole' }}
    end

    it { expect(response).to redirect_to(items_path) }

    it 'and redirects to the Item\'s page' do
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end

  context 'DELETE /items' do
    let(:item) { create(:item, ownable: user) }

    before :each do
      delete item_path(item.id)
    end

    it { expect(response).to redirect_to(items_path) }

    it 'and redirects to the Item\'s page' do
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end
end
