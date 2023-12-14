class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  validates :body, presence: true
  default_scope {order(created_at: :desc)}
  after_create :generate_mail

  private
  def generate_mail
    UserMailer.with(tweet: tweet, user: user, comment: self).commented_email.deliver_now
  end
end
