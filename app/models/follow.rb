class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
  after_create :generate_mail

  private
  def generate_mail 
    UserMailer.with(follower: follower, followee: followee).follwed_email.deliver_now
  end
end
