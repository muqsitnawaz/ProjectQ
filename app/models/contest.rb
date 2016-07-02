class Contest < ActiveRecord::Base
	has_many :contest_answers
	belongs_to :user

	serialize :topics
end
