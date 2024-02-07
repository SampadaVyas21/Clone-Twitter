require 'rails_helper'
RSpec.describe RetweetsController, type: :controller do
	before do
		@user = FactoryBot.create(:user)
		@tweet = FactoryBot.create(:tweet, user_id: @user.id)
		sign_in @user
  end
	describe 'GET retweet' do
		it "returns a successful response" do
			get :retweet, params: { tweet_id: @tweet.id}
			expect(response).to have_http_status(302)
		end
	end
end