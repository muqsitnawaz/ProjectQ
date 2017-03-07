class Article < ActiveRecord::Base
  # Search engine stuff
  include SearchCop

  search_scope :csearch do
    attributes :heading, :intro, :content, :topics
  end
  
  belongs_to :user

  serialize :topics

  # Validations
  validates_associated :user
  validates :heading, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :intro, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :content, presence: true, uniqueness: true, length: { minimum: 5 }
end
