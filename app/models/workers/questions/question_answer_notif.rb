class QuestionAnswerNotif
  @queue = :question_answer_notifs_queue
  
  def self.perform(answer_id)
    answer = Answer.find_by_id(answer_id)
    
    if !answer.nil?
      notif1 = Notification.new({
        :user_id => answer.question.user_id,
        :poster_id => answer.user_id,
        :resource_type => "Question",
        :notification_type => 1,
        :resource_id => answer.question_id
      })
      notif1.save
    end
  end
end