class AnswersController < ApplicationController


def create
  @answer = current_user.answers.build(answer_params)
  if @answer.save
    redirect_to questions_path(:id => params[:answer][:question_id])
  else
    redirect_to root_path
  end
end

private
   def answer_params
     params.require(:answer).permit(:question_id, :user_id, :answer, :image, :upvotes, :downvotes)
   end
end
