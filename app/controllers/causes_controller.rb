require 'resque'
require_relative './workers/causes/cause_agree_notif'
require_relative './workers/causes/cause_disagree_notif'

class CausesController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]
  
  # Creating a cause
  def create
    @cause = current_user.causes.build(cause_params)
    
    if @cause.save
      flash[:notice] = 'cause created'
      # redirect to the respective page on basis of pledge or dont
     if params[:cause][:dont_pledge] == true || params[:cause][:dont_pledge] == "1"
        redirect_to(controller: 'causes',action: 'petition', id: @cause.id)
      else
        redirect_to(controller: 'causes',action: 'pledge', id: @cause.id)
      end
      # redirect_to cause_path(:id => @cause.id)
    else
      flash[:notice] = 'cause creation failed'
      redirect_to questions_path
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
        redirect_to questions_path
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
      redirect_to questions_path
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
      
      # Generating notifcation
      Resque.enqueue(CauseAgreeNotif, @cause.id, current_user.id)
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
      
      # Generating notifcation
      Resque.enqueue(CauseDisagreeNotif, @cause.id, current_user.id)
    else
      if request.xhr?
        render :json => {
          :status => "resource not found"
        }
      end
    end
  end
  
  def petition
    flash[:success] = "Welcome to the Sample App!"
    @cause = Cause.find_by_id(params[:id])
  end
  
  def petition_update
    @cause = Cause.find_by_id(params[:cause_id])
    if !@cause.nil?
      @cause.petitiondate = params[:cause][:petitiondate]
      @cause.petitionTo = params[:cause][:petitionTo]
      @cause.petition_signs = params[:cause][:petition_signs]
      @cause.petition_help = params[:cause][:petition_help]
      if @cause.save
        redirect_to(controller: 'causes',action: 'pledge_view', cause_id: @cause.id)
      else
        redirect_to articles_path
      end
    end
  end
  
  def pledge
    @cause = Cause.find_by_id(params[:id])
  end

  def pledge_update
    @cause = Cause.find_by_id(params[:cause_id])
    if !@cause.nil?
      @cause.pledgeDate = params[:cause][:pledgeDate]
      @cause.pledgeTo = params[:cause][:pledgeTo]
      @cause.pledgeStep = params[:cause][:pledgeStep]
      @cause.totalpeople = params[:cause][:totalpeople]
      @cause.howhelp = params[:cause][:howhelp]
      if @cause.save
        redirect_to(controller: 'causes',action: 'pledge_view', cause_id: @cause.id)
      else
        redirect_to articles_path
      end
    end
  end
  
  def petition_view
    @cause = Cause.find_by_id(params[:cause_id])
  end
  
  def pledge_view
    @cause = Cause.find_by_id(params[:cause_id])
  end
  
  #to upadte the pledge
  
  def edit_pledge
    @cause = Cause.find_by_id(params[:cause_id])
  end
  def update_pledge
    @cause = Cause.find_by_id(params[:cause_id])
    if !@cause.nil?
      @cause.pledgeDate = params[:cause][:pledgeDate]
      @cause.pledgeTo = params[:cause][:pledgeTo]
      @cause.pledgeStep = params[:cause][:pledgeStep]
      @cause.totalpeople = params[:cause][:totalpeople]
      @cause.howhelp = params[:cause][:howhelp]
      if @cause.save
        redirect_to(controller: 'causes',action: 'pledge_view', cause_id: @cause.id)
      end
    end
  end
  # edit petition
  def edit_petition
    @cause = Cause.find_by_id(params[:cause_id])
  end
  
  def update_petition
    @cause = Cause.find_by_id(params[:cause_id])
    if !@cause.nil?
      @cause.petitiondate = params[:cause][:petitiondate]
      @cause.petitionTo = params[:cause][:petitionTo]
      @cause.petition_signs = params[:cause][:petition_signs]
      @cause.petition_help = params[:cause][:petition_help]
      if @cause.save
        redirect_to(controller: 'causes',action: 'pledge_view', cause_id: @cause.id)
      end
    end
  end  
  
  def image_upload
    @cause = Cause.find_by_id(params[:cause_id])
    if !@cause.nil?
      @cause.image = params[:cause][:image]
      if @cause.save
        redirect_to cause_completed_path(cause_id: @cause.id)
      end
    end
  end
  
  def completed_cause
    @cause = Cause.find_by_id(params[:cause_id])
  end
private
  def cause_params
    params.require(:cause).permit(:user_id, :cause_type, :intro, :detail, :whymatters, :anonymous, :image,:pledgeDate,:pledgeStep,:pledgeTo,:howhelp,:totalpeople,:pledge,:dont_pledge)
  end
end
