class Question < ActiveRecord::Base
  # Search engine stuff
  include SearchCop

  search_scope :search do
    attributes :content, :detail, :topics
  end
  
  belongs_to :user
  has_many :answers
  
  mount_uploader :image, ImageUploader

  serialize :topics
  serialize :followers

  # Validations
  validates_associated :user
  validates :content, presence: true, length: { minimum: 5, maximum: 50 }
  validates :detail, presence: true, length: { minimum: 5 }
end