require 'rails_helper'

RSpec.describe "Sessions", :type => :request do
  it "signs user in and out" do
    user = create(:user)

    sign_in user
    get root_path

    expect(response).to render_template(:index)

    sign_out user
    get root_path

    expect(response).not_to render_template(:index)
  end
end

