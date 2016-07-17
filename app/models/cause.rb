class Cause < ActiveRecord::Base
  # Search engine stuff
  include SearchCop

  search_scope :search do
    attributes :cause_type, :intro, :detail, :whymatters
  end
  
  belongs_to :user
  has_many :cause_comments

  # Image uploader
  mount_uploader :image, ImageUploader

  # Serializers
  serialize :followers

  # Validations
  validates_associated :user
  validates :intro, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :detail, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :whymatters, presence: true, uniqueness: true, length: { minimum: 5 }
end
