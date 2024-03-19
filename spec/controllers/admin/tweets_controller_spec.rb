require 'rails_helper'

RSpec.describe Admin::TweetsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views
  let!(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}

  before do 
  	@file = fixture_file_upload(Rails.root.join('spec/fixtures/girlpic.png'), 'image/jpeg')
  	@file_1 = fixture_file_upload(Rails.root.join('spec/fixtures/video1.mp4'), 'video/mpeg')
  	
    @user = FactoryBot.create(:user)
    
    image = ActiveStorage::Blob.create_and_upload!(
						 io: File.open(@file, 'rb'),filename: 'girlpic.png',content_type: 'image/jpeg').signed_id
		@tweet = Tweet.create(images: image, user_id: @user.id, content: "hellooo")
    
    video = ActiveStorage::Blob.create_and_upload!(
						 io: File.open(@file_1, 'rb'),filename: 'video1.mp4',content_type: 'video/mpeg').signed_id
		@tweet_1 = Tweet.create(images: video, user_id: @user.id, content: "hellooo")

		@comment = FactoryBot.create(:comment, tweet_id: @tweet.id, user_id: @user.id)

    sign_in admin_user
  end
  
  describe 'GET /' do
    it 'reponds with success' do
      get :index, params: { user_id: @user.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers show for images'  do 
      get :show, params: {user_id: @user.id, id: @tweet.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers show for videos'  do 
      get :show, params: {user_id: @user.id, id: @tweet_1.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers new and edit for images'  do 
      get :edit, params: { user_id: @user.id, id: @tweet.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers new and edit for videos'  do 
      get :edit, params: { user_id: @user.id, id: @tweet_1.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET member action" do 
  	it 'covers member action' do 
  		get :change_month, params: {user_id: @user.id, id: @tweet.id, month: 'april'}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
  	end
  end

  describe "POST batch action" do 
  	it "covers batch action for report" do 
  		post :batch_action, params: {user_id: @user.id, batch_action: 'report', collection_selection: [@tweet.id]}
      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
  	end

    it "covers batch action for unreport" do 
      post :batch_action, params: {user_id: @user.id, batch_action: 'unreport', collection_selection: [@tweet.id]}
      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT update" do 
    it "updates" do 
      put :update, params: { id: @tweet.id, user_id: @user.id, tweet: {report: true}}
      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
    end
  end
end