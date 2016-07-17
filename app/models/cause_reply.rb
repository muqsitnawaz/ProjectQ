class CauseReply < ActiveRecord::Base
  before_create do |cause_reply|
    # Notification of form 'User replied on your cause'
    notif = Notification.new({
      :user_id => cause_reply.cause_comment.cause.user_id,
      :poster_id => cause_reply.user_id,
      :resource_type => "Cause",
      :notification_type => 2,
      :resource_id => cause_reply.cause_comment.cause_id
    })
    notif.save
  end
  
  belongs_to :user
  belongs_to :cause_comment
  
  # Validations
  validates_associated :user
  validates_associated :cause_comment
  validates :reply, presence: true, uniqueness: true, length: { minimum: 5 }
end
