require 'rails_helper'
RSpec.describe LikesController, type: :controller do
	before do
		@user = FactoryBot.create(:user)
		@tweet = FactoryBot.create(:tweet, user_id: @user.id)
		@comment = FactoryBot.create(:comment, tweet_id: @tweet.id, user_id: @user.id)
		sign_in @user
  end
	describe 'POST create' do
		it "returns a successful response" do
			post :create, params: { tweet_id: @tweet.id}
			expect(response.body).present?
			expect(response).to have_http_status(200)
		end

		it "returns a successful response for already liked" do
			Like.create(user_id: @user.id, tweet_id: @tweet.id)
			post :create, params: { tweet_id: @tweet.id}
			expect(flash[:notice]).to eq("You can't like more than once")
			expect(response.body).present?
			expect(response).to have_http_status(200)
		end
	end

	describe 'DELETE destroy new' do
		it 'returns successful response' do
			@like = Like.create(user_id: @user.id, tweet_id: @tweet.id)
			delete :destroy, params: { id: @like.id, tweet_id: @tweet.id}
			expect(response).to have_http_status(200)
		end

		it 'returns unsuccessful response' do
			delete :destroy, params: { id: 12, tweet_id: @tweet.id}
			expect(flash[:notice]).to eq("Cannot unlike")
			expect(response).to have_http_status(200)
		end

	end

	describe 'GET check ' do 
		it 'returns a successful response for check' do 
			get :check, params: { tweet_id: @tweet.id}
			expect(response).to have_http_status(200)
			expect(response.body).to eq('false')
		end

		it 'returns a successful response for check when already liked' do
			@like = Like.create(user_id: @user.id, tweet_id: @tweet.id) 
			get :check, params: { tweet_id: @tweet.id}
			expect(response).to have_http_status(200)
			expect(response.body).present?
		end

	# 	it 'returns a successful response for strong params' do 
	# 		post :create, params: {tweet_id: @tweet.id, comment: { tweet_id: @tweet.id, body: "helllooo", user_id: @user.id}}
	# 		expect(response).to have_http_status(302)
	# 	end

	# 	it 'returns a unsuccessful response' do 
	# 		post :create, params: {tweet_id: @tweet.id, comment: { tweet_id: @tweet.id, body: " ", user_id: @user.id}}
	# 		expect(flash[:notice]).to eq("Body can't be blank")
	# 		expect(response).to have_http_status(302)
	# 	end
	end
end