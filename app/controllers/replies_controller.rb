class RepliesController < ApplicationController

  def create
    @reply = current_user.replies.build(reply_params)
    if @reply.save
      redirect_to questions_path(:id => Answer.find_by_id(reply_params[:answer_id]).question.id)
    else
      redirect_to root_path
    end
  end

private
  def reply_params
    params.require(:reply).permit(:answer_id, :user_id, :reply)
  end
end
