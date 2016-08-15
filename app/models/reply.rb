class Reply < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  # Validations
  validates_associated :user
  validates_associated :answer
  validates :content, presence: true, uniqueness: true, length: { minimum: 5 }
end
