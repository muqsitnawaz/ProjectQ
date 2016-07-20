class AnswerReplyNotif
  @queue = :answer_reply_notifs_queue
  
  def self.perform(reply_id)
    reply = Reply.find_by_id(reply_id)
    
    if !reply.nil?
      notif3 = Notification.new({
        :user_id => reply.answer.user_id,
        :poster_id => reply.user_id,
        :resource_type => "Question",
        :notification_type => 3,
        :resource_id => reply.answer.question_id
      })
      notif3.save
    end
  end
end