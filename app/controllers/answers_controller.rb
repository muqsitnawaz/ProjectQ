require 'resque'
require_relative './workers/questions/question_answer_notif'
require_relative './workers/questions/question_answer_follower_notif'

class AnswersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show ]

  def create
    @answer = current_user.answers.build(answer_params)
    
    if @answer.save
      flash[:notice] = 'answer created'
      
      # Generating notification and redirecting
      Resque.enqueue(QuestionAnswerNotif, @answer.id)
      @answer.question.followers.each do |follower|
        Resque.enqueue(QuestionAnswerFollowerNotif, @answer.id, follower)
      end
      redirect_to question_path(:id => params[:answer][:question_id])
    else
      flash[:notice] = 'answer creation failed'
      redirect_to root_path
    end
  end

  def update
    @answer = Answer.find_by_id(params[:answer_id])

    if !@answer.nil?
      @answer.answer = params[:answer]
      @answer.save

      if request.xhr?
        render :json => {
          :status => "success"
        }
      end
    else
      if request.xhr?
        render :json => {
          :status => "failure"
        }
      end
    end
  end

  def destroy
    @answer = Answer.find_by_id(params[:id])
    question_id =@answer.question_id

    if @answer.user == current_user
      @answer.destroy
      flash[:notice] = 'answer destroyed'
    else
      flash[:notice] = "not sufficient permission"
    end
    
    redirect_to question_path(:id => question_id)
  end

  # Upvoting an answer
  def upvote
    @answer = Answer.find_by_id(params[:answer_id].to_i)
    @answer.upvotes += 1
    @answer.save

    if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end

  # Downvoting an answer
  def downvote
    @answer = Answer.find_by_id(params[:answer_id].to_i)
    @answer.downvotes += 1
    @answer.save

    if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end

private
  def answer_params
    params.require(:answer).permit(:question_id, :user_id, :answer, :image, :anonymous)
  end
end
