class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  after_create :generate_mail

  private
  def generate_mail 
    UserMailer.with(user: user, tweet: tweet).liked_email.deliver_now
  end
end
