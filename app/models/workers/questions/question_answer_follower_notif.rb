class QuestionAnswerFollowerNotif
  @queue = :question_answer_follower_notifs_queue
  
  def self.perform(answer_id, follower)
    answer = Answer.find_by_id(answer_id)
    
    if !answer.nil?
      notif2 = Notification.new({
        :user_id => follower,
        :poster_id => answer.user_id,
        :resource_type => "Question",
        :notification_type => 2,
        :resource_id => answer.question_id
      })
      notif2.save
    end
  end
end