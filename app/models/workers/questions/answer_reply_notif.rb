class AnswerReplyNotif
  @queue = :answer_reply_notifs_queue
  
  def self.perform(reply_id)
    reply = Reply.find_by_id(reply_id)
    
    if !reply.nil?
      user_id = reply.answer.user_id
      
      # Saving notification
      notif3 = Notification.new({
        :user_id => user_id,
        :poster_id => reply.user_id,
        :resource_type => "Question",
        :notification_type => 3,
        :resource_id => reply.answer.question_id
      })
      notif3.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end