require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views
  let!(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}

  before do 
    @user = FactoryBot.create(:user, bluetick: true)
    @tweet = FactoryBot.create(:tweet, user_id: @user.id)
    @retweet = FactoryBot.create(:retweet, user_id: @user.id, tweet_id: @tweet.id)
    sign_in admin_user
  end
  describe 'GET /' do
    it 'reponds with success' do
      get :index
      expect(response).to be_successful
    end
  end
end