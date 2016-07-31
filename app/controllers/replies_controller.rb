require 'resque'
require_relative './workers/questions/answer_reply_notif'

class RepliesController < ApplicationController
  def create
    @reply = current_user.replies.build(reply_params)
    
    if @reply.save
      flash[:notice] = 'reply created'
      
      # Generating notification and redirecting
      Resque.enqueue(AnswerReplyNotif, @reply.id)
      redirect_to question_path(:id => @reply.answer.question_id)
    else
      flash[:notice] = 'reply creation failed'
      redirect_to questions_path
    end
  end

  def update
    @reply = Reply.find_by_id(params[:reply_id])

    if !@reply.nil?
      @reply.reply = params[:reply]
      @reply.save

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
    @reply = Reply.find_by_id(params[:id])
    question_id = @reply.answer.question_id

    if @reply.user == current_user
      @reply.destroy
      flash[:notice] = 'reply destroyed'
    else
      flash[:notice] = "not sufficient permission"
    end
    
    redirect_to question_path(:id => question_id)
  end

private
  def reply_params
    params.require(:reply).permit(:answer_id, :user_id, :reply, :anonymous)
  end
end
