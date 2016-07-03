class Cause < ActiveRecord::Base
  belongs_to :user
  has_many :cause_comments

  # Validations
  validates_associated :user
  validates :intro, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :detail, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :whymatters, presence: true, uniqueness: true, length: { minimum: 5 }
end
