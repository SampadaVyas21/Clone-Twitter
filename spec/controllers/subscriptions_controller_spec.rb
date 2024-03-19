require 'rails_helper'
RSpec.describe SubscriptionsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @subscription = Subscription.create(plan: 'gold', validity: Date.today, price: 2999, activated: true)
    sign_in @user
  end
  describe 'GET index' do
    it "returns a successful response" do
      get :subs_plans
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end