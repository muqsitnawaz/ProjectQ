require 'resque'
require_relative './workers/questions/answer_reply_notif'

class Reply < ActiveRecord::Base
  after_create do |reply|
    # Notification of form 'User relplied to your answer'
    Resque.enqueue(AnswerReplyNotif, reply.id)
  end

  belongs_to :answer
  belongs_to :user

  # Validations
  validates_associated :user
  validates_associated :answer
  validates :reply, presence: true, uniqueness: true, length: { minimum: 5 }
end
