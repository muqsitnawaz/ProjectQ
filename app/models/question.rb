class Question < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :content, :uniqueness => true
end
