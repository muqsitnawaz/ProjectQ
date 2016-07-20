require 'resque'
require_relative './workers/questions/question_answer_notif'
require_relative './workers/questions/question_answer_follower_notif'

class Answer < ActiveRecord::Base
  # Sending notifcations to users after answer is created
  
  after_create do |answer|
    # Notification of form 'User answered your question'
    Resque.enqueue(QuestionAnswerNotif, answer.id)
    
    # Notification of form 'User answered a question you're following
    answer.question.followers.each do |follower|
      Resque.enqueue(QuestionAnswerFollowerNotif, answer.id, follower)
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