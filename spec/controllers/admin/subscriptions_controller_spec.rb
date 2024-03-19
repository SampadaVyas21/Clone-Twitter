require 'rails_helper'

RSpec.describe Admin::SubscriptionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views
  let!(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}

  before do 
    sign_in admin_user
    @subscription = Subscription.create(plan: 'gold', validity: Date.today, price: 2999, activated: true)
  end
  describe 'GET /' do
    it 'responds with success' do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "returns successful response for show" do 
      get :show, params: { id: @subscription.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "returns successful response for new" do 
      get :new
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end