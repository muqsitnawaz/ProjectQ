class Answer < ActiveRecord::Base
  before_create do |answer|
    # Notification of form 'User answered your question'
    notification1 = Notification.new({
      :user_id => answer.question.user_id,
      :poster_id => answer.user_id,
      :resource_type => "Question",
      :notification_type => 1,
      :resource_id => answer.question_id
    })
    notification1.save

    # Notification of form 'User answered a question you're following
    answer.question.followers.each do |follower|
      notification2 = Notification.new({
        :user_id => follower,
        :poster_id => answer.user_id,
        :resource_type => "Question",
        :notification_type => 2,
        :resource_id => answer.question_id
      })
      notification2.save
    end
  end

  belongs_to :question
  belongs_to :user
  has_many :replies

  mount_uploader :image, ImageUploader

  # Validations
  validates_associated :user
  validates_associated :question
  validates :answer, presence: true, uniqueness: true, length: { minimum: 5 }
end