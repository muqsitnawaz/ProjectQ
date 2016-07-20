class CauseDisagreeNotif
  @queue = :cause_disagree_notifs_queue
  
  def self.perform(cause_id, current_user_id)
    cause = Cause.find_by_id(cause_id)
    
    if !cause.nil?
      user_id = cause.user_id
      
      # Saving notification
      notif4 = Notification.new({
        :user_id => user_id,
        :poster_id => current_user_id,
        :resource_type => "Cause",
        :notification_type => 4,
        :resource_id => cause.id
      })
      notif4.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end