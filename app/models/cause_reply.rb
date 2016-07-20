require 'resque'
require_relative './workers/causes/comment_reply_notif'

class CauseReply < ActiveRecord::Base
  after_create do |cause_reply|
    # Notification of form 'User replied on your cause'
    Resque.enqueue(CommentReplyNotif, cause_reply.id)
  end
  
  belongs_to :user
  belongs_to :cause_comment
  
  # Validations
  validates_associated :user
  validates_associated :cause_comment
  validates :reply, presence: true, uniqueness: true, length: { minimum: 5 }
end
