class CauseComment < ActiveRecord::Base
  before_create do |cause_comment|
    # Notification of form 'User comment on your cause'
    notif = Notification.new({
      :user_id => cause_comment.cause.user_id,
      :poster_id => cause_comment.user_id,
      :resource_type => "Cause",
      :notification_type => 1,
      :resource_id => cause_comment.cause_id
    })
    notif.save
  end
  
  belongs_to :user
  belongs_to :cause
  
  has_many :cause_replies

  # Validations
  validates_associated :user
  validates_associated :cause
  validates :comment, presence: true, uniqueness: true, length: { minimum: 5 }
end
