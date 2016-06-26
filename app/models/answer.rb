class Answer < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :replies

  belongs_to :question
  belongs_to :user
end
