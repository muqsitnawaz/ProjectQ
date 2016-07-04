class CausesController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  # Creating a case
  def create
    @cause = current_user.causes.build(cause_params)
    
    if @cause.save
      redirect_to causes_path(:id => @cause.id)
      flash[:notice] = 'cause created'
    else
      redirect_to root_path
    end
  end

  # Showing causes
  def show
    @causes = Cause.all.order('created_at DESC')
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
          :status => "failure"
        }
      end
    end
  end

  # Deleting a cause
  def destroy
    @cause = Cause.find_by_id(params[:id])

    if @cause.user == current_user
      @cause.destroy
      flash[:notice] = 'cause deleted'
    end

    redirect_to request.path
  end

private
  def cause_params
    params.require(:cause).permit(:user_id, :cause_type, :intro, :detail, :whymatters, :image)
  end
end
