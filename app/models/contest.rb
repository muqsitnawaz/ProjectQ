class Contest < ActiveRecord::Base
  has_many :contest_answers
  belongs_to :user

  # Serializer
  serialize :topics

  # Image uploader
  mount_uploader :image, ImageUploader

  # Validations
  validates_associated :user
  validates :content, presence: true, uniqueness: true, length: { minimum: 5, maximum: 75 }
  validates :detail, presence: true, length: { minimum: 5 }
  validates :prize, presence: true, numericality: true
  validates :end_date, presence: true
end
