class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  mount_uploader :image, ImageUploader
  validates :content, :uniqueness => true
  serialize :topics
end
