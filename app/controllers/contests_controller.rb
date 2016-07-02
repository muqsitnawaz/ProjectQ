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
        if params[:id].nil?
          @contests = Contest.where(:user_id => current_user.id)
        else
          @contest = Contest.find_by_id(params[:id])
        end
    else
      @contests = Contest.all
    end
  end

  def update
    @contest =Contest.find_by_id(params[:contest_id])

    if !@contest.nil?
      @contest.content = params[:contest_content]
      @contest.detail = params[:contest_detail]
      @contest.save

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
