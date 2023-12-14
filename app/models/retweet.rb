class Retweet < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope {order(created_at: :desc)}
  default_scope { where(:report => false)}
  has_many_attached :images
end
