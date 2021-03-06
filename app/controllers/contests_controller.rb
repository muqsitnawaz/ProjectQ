class ContestsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show ]

  def index
    if is_admin?                # Check for admin
      @is_admin = true
      if params[:type] == 'open'
        @contests = Contest.where(:user_id => current_user.id,:status => 'open').order('created_at DESC')
      elsif params[:type] == 'close'
        @contests = Contest.where(:status => 'close').order('created_at DESC')
      else
        flash[:notice] = 'invalid request'
        redirect_to questions_path
      end
    elsif user_signed_in?       # Check for users
      if params[:type] == 'open'
        @contests = Contest.where(:status => 'open').order('created_at DESC')
        @contestwon = Contest.where(:winner_id => current_user.id).order('created_at DESC')
        @contestclosed = Contest.where(:status => 'close').order('created_at DESC')
        @contestpart = Contest.where(:id => ContestAnswer.where(:user_id => current_user.id).map {|a| a.contest_id}).order('created_at DESC')
      elsif params[:type] == 'close'
        @contests = Contest.where(:status => 'close').order('created_at DESC')
      elsif params[:type] == 'won'
        @contests = Contest.where(:winner_id => current_user.id).order('created_at DESC')
      elsif params[:type] == 'participated'
        @contests = Contest.where(:id => ContestAnswer.where(:user_id => current_user.id).map {|a| a.contest_id}).order('created_at DESC')
      else
        flash[:notice] = 'invalid request'
        redirect_to questions_path
      end
    else                        # Otherwise
      @contests = Contest.all.order('created_at DESC')
    end
  end
  
  def show
    if is_admin?                # Check for admin
      @is_admin = true
      @contest = Contest.find_by_id(params[:id])
      
      if @contest.nil?
        flash[:notice] = 'contest not found'
        redirect_to questions_path
      end
    else
      flash[:notice] = 'not sufficient permission'
      redirect_to questions_path
    end
  end

  # Creating a contest, admin only
  def create
    if is_admin?
      @contest = current_user.contests.build(contest_params)

      if @contest.save
        redirect_to contest_path(:id => @contest.id)
      else
        flash[:notice] = "contest couldn't be created"
        redirect_to questions_path
      end
    else
      flash[:notice] = 'not sufficient permission'
      redirect_to questions_path
    end
  end

  # Updating contest via ajax call
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

  # Destroying a contest
  def destroy
    @contest = Contest.find_by_id(params[:id])

    if is_admin?
      if @contest.nil?
        flash[:notice] = 'contest not found'
      else
        @contest.destroy
        flash[:notice] = "contest deleted"
      end
    end

    redirect_to questions_path
  end
protected
  def contest_params
    params.require(:contest).permit(:user_id, :prize, :content, :detail, :image, :end_date, :topics => [])
  end
end
