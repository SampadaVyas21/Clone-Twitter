require 'rails_helper'
RSpec.describe FollowsController, type: :controller do
	before do
		@user = FactoryBot.create(:user)
		sign_in @user
  end
	
	describe 'GET follow' do
		it "returns a successful response for follow" do
			get :follow, params: { id: @user.id}
			expect(response).to have_http_status(302)
		end
	end

	describe 'GET unfollow' do
		it "returns a successful response for unfollow" do
			@user.followees << @user	
			get :unfollow, params: { id: @user.id}
			expect(response).to have_http_status(302)
		end
	end
end