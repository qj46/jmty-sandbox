require 'rails_helper'

RSpec.describe "Dashboards", type: :request do

  describe "GET index" do
    it 'routes to dashboard#index as root' do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get "/dashboard/"
      expect(response).to have_http_status(:success)
    end
    
    it 'sets should_render_navbar to true' do
      get "/dashboard/"
      expect(assigns(:should_render_navbar)).to eq(true)
    end
  end

  describe 'GET show' do
    let(:user) { FactoryBot.create(:user) }
    
    it 'sets @user when user exists' do
      get "http://localhost:3000/1", params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
    
    it 'sets @user to nil when user does not exist' do
      get "http://localhost:3000/1", params: { id: 'invalid_id' }
      expect(assigns(:user)).to be_nil
    end
  end


  # describe "GET /appearance" do
  #   it "returns http success" do
  #     get "/appearance/"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
