require 'rails_helper'
RSpec.describe LikesController, type: :controller do

	let!(:success_message) { " returns a successful response "}

	before do
		@success_message = success_message
		@user = FactoryBot.create(:user)
		@tweet = FactoryBot.create(:tweet, user_id: @user.id)
		@comment = FactoryBot.create(:comment, tweet_id: @tweet.id, user_id: @user.id)
		sign_in @user
  end
	describe 'POST create' do
		it @success_message do
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
		it @success_message do
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
	end
end