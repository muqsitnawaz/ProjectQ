class CauseAgreeNotif
  @queue = :cause_agree_notifs_queue
  
  def self.perform(cause_id, current_user_id)
    cause = Cause.find_by_id(cause_id)
    
    if !cause.nil?
      user_id = cause.user_id
      
      # Saving notification
      notif3 = Notification.new({
        :user_id => user_id,
        :poster_id => current_user_id,
        :resource_type => "Cause",
        :notification_type => 3,
        :resource_id => cause.id
      })
      notif3.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end