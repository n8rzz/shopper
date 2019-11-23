require "rails_helper"

RSpec.describe "Location", :type => :request do
  before do
    sign_in create(:user)
  end

  context '/locations route' do
    context 'renders #index template' do
      before :each do
        get locations_path
      end

      it { expect(response).to render_template(:index) }
      it { expect(response).to_not render_template(:show) }
    end
  end

  context '/locations/new route' do
    context 'renders #new template' do
      before :each do
        get new_location_path
      end

      it { expect(response).to render_template(:new) }
      it { expect(response).to_not render_template(:show) }
    end

    context 'create a Location' do
      before :each do
        post "/locations", :params => { :location => attributes_for(:location) }
      end

      it { expect(response).to redirect_to(locations_path) }

      it "redirects to the Locations page" do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end
  end
end
