require 'rails_helper'
RSpec.describe HomeController, type: :controller do
	before do
		@user = FactoryBot.create(:user)
		@tweet = FactoryBot.create(:tweet, user_id: @user.id)
		@retweet = FactoryBot.create(:retweet, user_id: @user.id, tweet_id: @tweet.id)
		sign_in @user
  end
	
	describe 'GET index' do
		it "returns a successful response for sign in" do
			get :index
			expect(response).to have_http_status(302)
		end

		it "returns a successful response for signed out" do
			sign_out @user	
			get :index
			expect(response).to have_http_status(302)
		end
	end

	describe 'GET userprofile' do 
		it 'returns a successful response' do
			get :userprofile
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET casebtn' do 
		it 'returns a successful response for follower' do 
			get :casebtn, params: { home_id: 'follower'}
			expect(response).to have_http_status(200)
		end

		it 'returns a successful response for following' do 
			get :casebtn, params: { home_id: 'following'}
			expect(response).to have_http_status(200)
		end

		it 'returns a successful response for sugg' do 
			get :casebtn, params: { home_id: 'sugg'}
			expect(response).to have_http_status(200)
		end

		it 'returns a successful response for retweets' do 
			get :casebtn, params: { home_id: 'retweets'}
			expect(response).to have_http_status(200)
		end

		it 'returns a successful response for else condition' do 
			get :casebtn, params: { home_id: 'kj'}
			expect(response).to have_http_status(200)
		end
	end
end