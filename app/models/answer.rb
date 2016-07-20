class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :replies

  mount_uploader :image, ImageUploader

  # Validations
  validates_associated :user
  validates_associated :question
  validates :answer, presence: true, uniqueness: true, length: { minimum: 5 }
end