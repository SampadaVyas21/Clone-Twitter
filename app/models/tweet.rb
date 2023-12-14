class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets
  validate :content_custom_validation
  validates :content, presence: true
  default_scope {order(created_at: :desc)}
  default_scope {where(:report => false)}
  has_one_attached :tweet_image
  has_many_attached :images

  accepts_nested_attributes_for :comments

  def self.search(search)
    where("lower(user.name) LIKE :search", search: "%#{search.downcase}%").uniq
  end

  private

  def content_custom_validation
    if content.length < 5 || content.length > 50  
      errors.add(:content, ": Content's Length must be between 5 to 50")
    end
  end

end