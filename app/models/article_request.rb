class ArticleRequest < ActiveRecord::Base
  belongs_to :user

  serialize :topics

  # Validations
  validates_associated :user
  validates :heading, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :explanation, presence: true, uniqueness: true, length: { minimum: 5 }
end
