class CausesController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]
  
  # Creating a cause
  def create
    @cause = current_user.causes.build(cause_params)
    
    if @cause.save
      flash[:notice] = 'cause created'
      redirect_to causes_path(:id => @cause.id)
    else
      flash[:notice] = 'cause creation failed'
      redirect_to root_path
    end
  end
  
  def index
    if !params[:type].nil?
      if params[:type] == 'followed'
        @causes = Cause.where(:id => current_user.causes_followed)
      elsif params[:type] == 'agreed'
        @causes = Cause.where(:id => current_user.causes_agreed)
      elsif params[:type] == 'disagreed'
        @causes = Cause.where(:id => current_user.causes_disagreed)
      else
        flash[:notice] = 'invalid request'
        redirect_to root_path
      end
    else
      @causes = Cause.all.order('created_at DESC')
    end
  end

  # Showing causes
  def show
    @cause = Cause.find_by_id(params[:id])
    
    if @cause.nil?
      flash[:notice] = 'cause not found'
      redirect_to root_path
    end
  end

  # Updating a cause
  def update
    @cause = Cause.find_by_id(params[:cause_id])

    if !@cause.nil?
      @cause.intro = params[:cause_intro]
      @cause.detail = params[:cause_detail]
      @cause.whymatters = params[:cause_whymatters]
      @cause.save

      if request.xhr?
        render :json => {
          :status => "success"
        }
      end
    else
      if request.xhr?
        render :json => {
          :status => "resource not found"
        }
      end
    end
  end

  # Deleting a cause
  def destroy
    @cause = Cause.find_by_id(params[:id])
    cause_id = @cause.id

    if @cause.user == current_user
      @cause.destroy
      flash[:notice] = 'cause deleted'
    else
      flash[:notice] = "not sufficient permission"
    end

    redirect_to causes_path
  end

  # Follow a cause
  def follow
    @cause = Cause.find_by_id(params[:cause_id])

    if !@cause.nil?
      @cause.followers << current_user.id
      @cause.save

      current_user.causes_followed << @cause.id
      current_user.save

      if request.xhr?
        render :json => {
          :status => "success"
        }
      end
    else
      if request.xhr?
        render :json => {
          :status => "resource not found"
        }
      end
    end
  end

  # Agree to a cause
  def agree
    @cause = Cause.find_by_id(params[:cause_id])

    if !@cause.nil?
      @cause.num_agree += 1
      @cause.save

      current_user.causes_agreed << @cause.id
      current_user.save

      if request.xhr?
        render :json => {
          :status => "success"
        }
      end
      
      # Generating notifcation to cause_owner
      notif = Notification.new({
        :user_id => @cause.user_id,
        :poster_id => current_user.id,
        :resource_type => "Cause",
        :notification_type => 3,
        :resource_id => @cause.id
      })
      notif.save
    else
      if request.xhr?
        render :json => {
          :status => "resource not found"
        }
      end
    end
  end

  # Disagree to a cause
  def disagree
    @cause = Cause.find_by_id(params[:cause_id])

    if !@cause.nil?
      @cause.num_disagree += 1
      @cause.save

      current_user.causes_disagreed << @cause.id
      current_user.save

      if request.xhr?
        render :json => {
          :status => "success"
        }
      end
      
      # Generating notifcation to cause_owner
      notif = Notification.new({
        :user_id => @cause.user_id,
        :poster_id => current_user.id,
        :resource_type => "Cause",
        :notification_type => 4,
        :resource_id => @cause.id
      })
      notif.save
    else
      if request.xhr?
        render :json => {
          :status => "resource not found"
        }
      end
    end
  end

private
  def cause_params
    params.require(:cause).permit(:user_id, :cause_type, :intro, :detail, :whymatters, :image)
  end
end
