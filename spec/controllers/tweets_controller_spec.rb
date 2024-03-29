require 'rails_helper'
RSpec.describe TweetsController, type: :controller do
	let!(:success_message) { " returns a successful response "}
	before do
		@success_message = success_message
		@user = FactoryBot.create(:user)
		@tweet = FactoryBot.create(:tweet, user_id: @user.id)
		@comment = FactoryBot.create(:comment, tweet_id: @tweet.id, user_id: @user.id)
		sign_in @user
  end
	describe 'GET index' do
		it @success_message do
			get :index
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET new' do
		it @success_message do
			get :new
			expect(response).to have_http_status(200)
		end
	end

	describe 'POST create ' do 
		it 'returns a successful response for strong params' do 
			post :create, params: { tweet: { content: "helllooo", user_id: @user.id}}
			expect(response).to have_http_status(302)
		end

		it 'returns a unsuccessful response' do 
			post :create, params: {tweet: { content: " ", user_id: @user.id}}
			expect(flash[:notice]).to eq("Content : Content's Length must be between 5 to 50 and Content can't be blank")
			expect(response).to have_http_status(302)
		end
	end

	describe 'GET feed' do 
		it @success_message do 
			get :feed
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET retweeting' do 
		it @success_message do
			get :retweeting, params: { tweet_id: @tweet.id }
			expect(response).to have_http_status(200) 
		end
	end
end