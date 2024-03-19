require 'rails_helper'
RSpec.describe Tweet, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  
  it "is valid with valid attributes" do
    expect(Tweet.new(content: "hjrhj", user_id: @user.id)).to be_valid
  end

  it "is invalid with invalid attributes" do
    expect(Tweet.new(content: " ", user_id: @user.id)).to_not be_valid
  end

  it "searches the user" do  
    tweet = Tweet.create(content: "Test project", user_id: @user.id)
    @result = Tweet.search(@user)
  end
end