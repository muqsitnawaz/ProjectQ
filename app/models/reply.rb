class Reply < ActiveRecord::Base
  before_create do |reply|
    # Notification of form 'User answered your question'
    notification = Notification.new({
      :user_id => reply.answer.user_id,
      :poster_id => reply.user_id,
      :resource_type => "Question",
      :notification_type => 3,
      :resource_id => reply.answer.question_id
    })
    notification.save
  end

  belongs_to :answer
  belongs_to :user

  # Validations
  validates_associated :user
  validates_associated :answer
  validates :reply, presence: true, uniqueness: true, length: { minimum: 5 }
end
