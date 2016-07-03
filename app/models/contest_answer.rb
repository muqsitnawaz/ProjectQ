class ContestAnswer < ActiveRecord::Base
	belongs_to :contest
	belongs_to :user

	# Image uploader
	mount_uploader :image, ImageUploader

	# Validations
	validates_associated :user
	validates_associated :contest
	validates :answer, presence: true, uniqueness: true, length: { minimum: 5 }
end
