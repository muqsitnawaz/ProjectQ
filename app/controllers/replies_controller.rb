class RepliesController < ApplicationController

  def create
    @reply = current_user.replies.build(reply_params)
    if @reply.save
      redirect_to questions_path(:id => Answer.find_by_id(reply_params[:answer_id]).question.id)
    else
      redirect_to root_path
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
    question_id = @reply.answer.question.id

    if @reply.user == current_user
      @reply.destroy
      redirect_to questions_path(:id => question_id)
    else
      flash[:notice] = "not sufficient permission"
      redirect_to root_path
    end
  end

private
  def reply_params
    params.require(:reply).permit(:answer_id, :user_id, :reply)
  end
end
