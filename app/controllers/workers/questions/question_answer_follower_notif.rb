class QuestionAnswerFollowerNotif
  @queue = :question_answer_follower_notifs_queue
  
  def self.perform(answer_id, follower)
    answer = Answer.find_by_id(answer_id)
    
    if !answer.nil?
      user_id = follower
      
      # Saving notification
      notif2 = Notification.new({
        :user_id => user_id,
        :poster_id => answer.user_id,
        :resource_type => "Question",
        :notification_type => 2,
        :resource_id => answer.question_id
      })
      notif2.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end