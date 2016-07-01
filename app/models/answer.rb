class Answer < ActiveRecord::Base
  before_create do |answer|
    # Notification of form 'User answered your question'
    notification1 = Notification.new({
      :user_id => answer.question.user_id,
      :notification_type => 1,
      :question_id => answer.question.id,
      :poster_id => answer.user_id
    })
    notification1.save

    # Notification of form 'User answered a question you're following
    answer.question.followers.each do |follower|
      notification2 = Notification.new({
        :user_id => follower,
        :notification_type => 2,
        :question_id => answer.question.id,
        :poster_id => answer.user_id
      })
      notification2.save
    end
  end

  belongs_to :question
  belongs_to :user
  has_many :replies

  mount_uploader :image, ImageUploader
end
