class CauseComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :cause
  
  has_many :cause_replies

  # Validations
  validates_associated :user
  validates_associated :cause
  validates :comment, presence: true, uniqueness: true, length: { minimum: 5 }
end
