class User < ApplicationRecord
  include ActiveStorage
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo  
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  has_many :tweets
  has_many :retweets
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :user_subscription, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :name, length: { minimum: 3 }
  validates :bio, length: { maximum: 30 }

  def past_retweets_chart
    Retweet.where(:user_id => self.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["bio", "created_at", "email", "followees", "followers", "id", "name", "bluetick", "updated_at", "username", "photo"]
  end

  # def ActiveStorage::Attachment.ransackable_attributes(auth_object = nil)
  #   ["blob_id", "created_at", "id", "name", "record_id", "record_type"
end

