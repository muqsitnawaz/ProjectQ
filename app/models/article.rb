class Article < ActiveRecord::Base
  belongs_to :user

  serialize :topics

  # Validations
  validates_associated :user
  validates :heading, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :intro, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :content, presence: true, uniqueness: true, length: { minimum: 5 }
end