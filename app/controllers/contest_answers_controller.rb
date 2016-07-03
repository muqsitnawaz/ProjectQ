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

  def mark_winner
    contest_answer = ContestAnswer.find_by_id(params[:contest_answer_id])

    if !contest_answer.nil?
      contest = contest_answer.contest

      # Closing contest when winner is selected
      contest.winner_chosen = true  
      contest.winner_id = contest_answer.user_id
      contest.status = 'close'
      contest.end_date = Time.now
      contest.save

      contest_answer.is_winner = true
      contest_answer.save

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

private
  def contest_answer_params
    params.require(:contest_answer).permit(:contest_id, :user_id, :answer, :image)
  end
end
