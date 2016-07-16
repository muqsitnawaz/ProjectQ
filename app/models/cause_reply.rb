class CauseReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :cause_comment
  
  # Validations
  validates_associated :user
  validates_associated :cause_comment
  validates :reply, presence: true, uniqueness: true, length: { minimum: 5 }
end
