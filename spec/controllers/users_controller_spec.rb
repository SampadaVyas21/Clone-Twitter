require 'rails_helper'
RSpec.describe UsersController, type: :controller do
	before do
		@user = FactoryBot.create(:user)
  end
	describe 'GET edit' do
		it "returns a successful response" do
			get :edit, params: { id: @user.id}
			expect(response).to have_http_status(200)
		end
	end

	describe 'PUT update' do
		it 'returns successful response' do
			put :update, params: { id: @user.id, user: { id: @user.id, username: 'harryp'}}
			expect(response).to have_http_status(302)
		end

		it 'returns unsuccessful response' do 
			put :update, params: { id: '89', user: { userame: "j"}}
			expect(response).to have_http_status(422)
		end
	end
end