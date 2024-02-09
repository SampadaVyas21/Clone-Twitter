require 'rails_helper'
RSpec.describe CommentsController, type: :controller do

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
			get :index, params: { tweet_id: @tweet.id}
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET new' do
		it @success_message do
			get :new, params: { tweet_id: @tweet.id}
			expect(response).to have_http_status(200)
		end
	end

	describe 'POST create ' do 
		it 'returns a successful response for strong params' do 
			post :create, params: { tweet_id: @tweet.id, body: "helllooo", user_id: @user.id}
			expect(response).to have_http_status(302)
		end

		it 'returns a successful response for strong params' do 
			post :create, params: {tweet_id: @tweet.id, comment: { tweet_id: @tweet.id, body: "helllooo", user_id: @user.id}}
			expect(response).to have_http_status(302)
		end

		it 'returns a unsuccessful response' do 
			post :create, params: {tweet_id: @tweet.id, comment: { tweet_id: @tweet.id, body: " ", user_id: @user.id}}
			expect(flash[:notice]).to eq("Body can't be blank")
			expect(response).to have_http_status(302)
		end
	end
end