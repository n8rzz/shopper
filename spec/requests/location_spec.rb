require "rails_helper"

RSpec.describe "Location", :type => :request do
  context '/locations route' do
    context 'renders #index template' do
      before :each do
        get "/locations"
      end

      it { expect(response).to render_template(:index) }
      it { expect(response).to_not render_template(:show) }
    end
  end

  # TODO: should be updated to use json request
  # context '/locations/new route' do
  #   context 'renders #new template' do
  #     before :each do
  #       get "/locations/new"
  #     end

  #     it { expect(response).to render_template(:new) }
  #     it { expect(response).to_not render_template(:show) }
  #   end

  #   context 'create a Location' do
  #     before :each do
  #       post "/locations", :params => { :locations => attributes_for(:location) }
  #     end

  #     it { expect(response).to redirect_to(locations_path) }

  #     it "redirects to the Locations page" do
  #       follow_redirect!

  #       expect(response).to render_template(:index)
  #     end
  #   end
  # end
end
