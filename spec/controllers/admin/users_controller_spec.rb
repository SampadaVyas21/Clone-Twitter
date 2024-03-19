require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views
  let!(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}

  before do 
    @user = FactoryBot.create(:user)
    sign_in admin_user
  end
  describe 'GET /' do
    it 'reponds with success' do
      get :index
      expect(response).to be_successful
    end

    it 'covers show'  do 
      get :show, params: {id: @user.id}
      expect(response).to be_successful
    end

    it 'covers new and edit'  do 
      get :new
      expect(response).to be_successful
    end
  end
end