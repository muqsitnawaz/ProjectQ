class ContestAnswersController < ApplicationController
	before_filter :is_admin?, except: [ :create ]

  def create
    @contest_answer = current_user.contest_answers.build(contest_answer_params)
    
    if @contest_answer.save
      flash[:notice] = "answer created"
      redirect_to contests_path(:type => :open)
    else
      flash[:notice] = "answer creation failed"
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
      
      # Generating notifcation to winner
      notif = Notification.new({
        :user_id => contest.winner_id,
        :poster_id => current_user.id,
        :resource_type => "Contest",
        :notification_type => 1,
        :resource_id => contest.id
      })
      notif.save
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
