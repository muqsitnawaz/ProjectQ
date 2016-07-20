require 'resque'
require_relative './workers/causes/cause_comment_notif'

class CauseComment < ActiveRecord::Base
  after_create do |cause_comment|
    # Notification of form 'User comment on your cause'
    Resque.enqueue(CauseCommentNotif, cause_comment.id)
  end
  
  belongs_to :user
  belongs_to :cause
  
  has_many :cause_replies

  # Validations
  validates_associated :user
  validates_associated :cause
  validates :comment, presence: true, uniqueness: true, length: { minimum: 5 }
end
