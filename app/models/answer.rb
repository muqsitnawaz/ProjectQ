class Answer < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :question
  belongs_to :user
end
