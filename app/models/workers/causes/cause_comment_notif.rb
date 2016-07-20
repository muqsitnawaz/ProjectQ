class CauseCommentNotif
  @queue = :cause_comment_notifs_queue
  
  def self.perform(cause_comment_id)
    cause_comment = CauseComment.find_by_id(cause_comment_id)
    
    if !cause_comment.nil?
      user_id = cause_comment.cause.user_id
      
      # Saving notification
      notif1 = Notification.new({
        :user_id => user_id,
        :poster_id => cause_comment.user_id,
        :resource_type => "Cause",
        :notification_type => 1,
        :resource_id => cause_comment.cause_id
      })
      notif1.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end