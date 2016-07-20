class CommentReplyNotif
  @queue = :comment_reply_notifs_queue
  
  def self.perform(cause_reply_id)
    cause_reply = CauseReply.find_by_id(cause_reply_id)
    
    if !cause_reply.nil?
      user_id = cause_reply.cause_comment.user_id
      
      # Saving notification
      notif2 = Notification.new({
        :user_id => user_id,
        :poster_id => cause_reply.user_id,
        :resource_type => "Cause",
        :notification_type => 2,
        :resource_id => cause_reply.cause_comment.cause_id
      })
      notif2.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end