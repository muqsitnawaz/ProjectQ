class ContestsController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  def create
    @contest = current_user.contests.build(contest_params)
    if @contest.save
      redirect_to contests_path
    else
      flash[:notice] = "contest couldn't be created"
      redirect_to root_path
    end
  end

  def show
    @interests = get_all_interests.sort!

    if is_admin?
        @is_admin = true
        @contests = Contest.where(:user_id => current_user.id)
    else
      @contests = Contest.all
    end
  end

  def destory
    @contest = Contest.find_by_id(params[:id])

    if is_admin?
      @contest.destroy
      flash[:notice] = "contest deleted"
    end

    redirect_to request.path
  end
protected
  def contest_params
    params.require(:contest).permit(:user_id, :prize, :content, :detail, :image, :end_date, :topics => [])
  end
end
