require 'rails_helper'

RSpec.describe Admin::AdsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views
  let!(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}
  let!(:success_message) { " returns a successful response "}

  before do 
    @success_message = success_message
    sign_in admin_user
    @file = fixture_file_upload(Rails.root.join('spec/fixtures/girlpic.png'), 'image/jpeg')
    image = ActiveStorage::Blob.create_and_upload!(
             io: File.open(@file, 'rb'),filename: 'girlpic.png',content_type: 'image/jpeg').signed_id
    @ad = Ad.create(ads_images: image, priorkey: 21, details: "helllloooooo" )

    @file_1 = fixture_file_upload(Rails.root.join('spec/fixtures/video1.mp4'), 'video/mpeg')
    @video = ActiveStorage::Blob.create_and_upload!(
             io: File.open(@file_1, 'rb'),filename: 'video1.mp4',content_type: 'video/mpeg').signed_id
    @ad_1 = Ad.create(ads_images: @video, priorkey:22, details: "hiiiiiii")

    @csv_file = fixture_file_upload(Rails.root.join('spec/fixtures/ads.csv'), 'text/csv')
    @csv_file_1 = fixture_file_upload(Rails.root.join('spec/fixtures/ads_csv.csv'), 'text/csv')
  end
  
  describe 'GET /' do
    it @success_message do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it @success_message do 
      get :upload_csv
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it @success_message do 
      post :import_csv, params: { dump: { file: @csv_file}}
      expect(response).to have_http_status(302)
    end

    it "returns unsuccessful response" do 
      post :import_csv, params: { dump: { file: @csv_file_1}}
      expect(response).to have_http_status(302)
    end

    it 'covers show when photo is attached' do 
      get :show, params: {id: @ad.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers show when video is attached' do 
      get :show, params: {id: @ad_1.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end    

    it 'restricts action' do 
      @ad_2 = Ad.create(ads_images: @video, priorkey:23, details: "hiiiiiii")
      @ad_3 = Ad.create(ads_images: @video, priorkey:24, details: "hiiiiiii")
      @ad_4 = Ad.create(ads_images: @video, priorkey:25, details: "hiiiiiii")
      get :show, params: { id: @ad_1.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers edit for photo' do 
      get :edit, params: { id: @ad.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'covers edit for video' do 
      get :edit, params: { id: @ad_1.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end