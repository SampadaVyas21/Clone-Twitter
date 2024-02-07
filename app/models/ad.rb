class Ad < ApplicationRecord
  has_many_attached :ads_images
  default_scope {order(priorkey: :asc)}
  validates :priorkey, presence: true, uniqueness: true
  validate :details_custom_valid
  validates :details, 
            length: {minimum: 2},
            format: { with: /([A-z])/ , message: "Details must contain atleast one Alphatbet" }

  HIGHEST = 1
  HIGH = 2
  NORMAL = 3
  LOW = 4
  LOWEST = 5


  STATUSES = {
    HIGHEST => 'Top Most',
    HIGH => 'Top',
    NORMAL => 'Middle',
    LOW => 'Bottom',
    LOWEST => 'Bottom Most'
  }

  private
  def details_custom_valid
    if details.blank?  
      errors.add(:details, "Details must present")
    end
  end

  # def ads_images=(attachables)
  #   ads_images.attach(attachables)
  # end
end
