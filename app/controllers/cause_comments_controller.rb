class CauseCommentsController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  # Creating a cause comment
  def create
    @cause_comment = current_user.cause_comments.build(cause_comment_params)
    
    if @cause_comment.save
      redirect_to causes_path
      flash[:notice] = "cause comment posted"
    else
      redirect_to root_path
    end
  end

  def update
    @cause_comment = CauseComment.find_by_id(params[:cause_comment_id])

    if !@cause_comment.nil?
      @cause_comment.comment = params[:cause_comment_comment]
      @cause_comment.save

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
    @cause_comment = CauseComment.find_by_id(params[:id])
    cause_id =@cause_comment.cause.id

    if @cause_comment.user == current_user
      @cause_comment.destroy
      flash[:notice] = "comment deleted"
      redirect_to causes_path(:id => cause_id)
    else
      flash[:notice] = "not sufficient permission"
      redirect_to root_path
    end
  end

def cause_comment_params
    params.require(:cause_comment).permit(:cause_id, :user_id, :comment)
  end
end