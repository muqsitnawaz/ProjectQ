class ContestAnswerNotif
  @queue = :contest_answer_notifs_queue
  
  def self.perform(contest_answer_id)
    contest_answer = ContestAnswer.find_by_id(contest_answer_id)
    
    if !contest_answer.nil?
      user_id = contest_answer.contest.user_id
      
      # Saving notification
      notif2 = Notification.new({
        :user_id => user_id,
        :poster_id => contest_answer.user_id,
        :resource_type => "Contest",
        :notification_type => 2,
        :resource_id => contest_answer.contest_id
      })
      notif2.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end