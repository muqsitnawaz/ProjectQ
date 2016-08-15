class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :replies

  # Validations
  validates_associated :user
  validates_associated :question
  validates :content, presence: true, uniqueness: true, length: { minimum: 5 }
end