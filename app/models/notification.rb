class Notification < ActiveRecord::Base
  belongs_to :user

  # Validations
  validates_associated :user
end
