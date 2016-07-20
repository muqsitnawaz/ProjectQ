class QuestionAnswerNotif
  @queue = :question_answer_notifs_queue
  
  def self.perform(answer_id)
    answer = Answer.find_by_id(answer_id)
    
    if !answer.nil?
      user_id = answer.question.user_id
      
      # Saving notification
      notif1 = Notification.new({
        :user_id => user_id,
        :poster_id => answer.user_id,
        :resource_type => "Question",
        :notification_type => 1,
        :resource_id => answer.question_id
      })
      notif1.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end