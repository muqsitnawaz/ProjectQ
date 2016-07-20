class AnswerWinnerNotif
  @queue = :answer_winner_notifs_queue
  
  def self.perform(contest_id, current_user_id)
    contest = Contest.find_by_id(contest_id)
    
    if !contest.nil?
      user_id = contest.winner_id
      
      # Saving notification
      notif1 = Notification.new({
        :user_id => user_id,
        :poster_id => current_user_id,
        :resource_type => "Contest",
        :notification_type => 1,
        :resource_id => contest.id
      })
      notif1.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end