class ContestAnswersController < ApplicationController
	before_filter :is_admin?, except: [ :create ]

  def create
    @contest_answer = current_user.contest_answers.build(contest_answer_params)
    if @contest_answer.save
      redirect_to contests_path
      flash[:notice] = "answer posted"
    else
      redirect_to root_path
    end
  end

private
  def contest_answer_params
    params.require(:contest_answer).permit(:contest_id, :user_id, :answer, :image)
  end
end
