class Reply < ActiveRecord::Base
  before_create do |reply|
    # Notification of form 'User answered your question'
    notification = Notification.new({
      :user_id => reply.answer.user_id,
      :notification_type => 3,
      :question_id => reply.answer.question.id,
      :poster_id => reply.user_id
    })
    notification.save
  end

  belongs_to :answer
  belongs_to :user
end
