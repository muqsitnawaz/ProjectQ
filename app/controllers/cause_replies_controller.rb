require 'resque'
require_relative './workers/causes/comment_reply_notif'

class CauseRepliesController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  # Creating a cause comment
  def create
    @cause_reply = current_user.cause_replies.build(cause_reply_params)
    
    if @cause_reply.save
      flash[:notice] = "cause reply created"
      
      # Generating notification and redirecting
      Resque.enqueue(CommentReplyNotif, @cause_reply.id)
      redirect_to cause_path(:id => @cause_reply.cause_comment.cause_id)
    else
      flash[:notice] = "cause reply creation failed"
      redirect_to root_path
    end
  end

  def update
    @cause_reply = CauseReply.find_by_id(params[:cause_reply_id])

    if !@cause_reply.nil?
      @cause_reply.reply = params[:cause_reply_reply]
      @cause_reply.save

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
    @cause_reply = CauseReply.find_by_id(params[:id])
    cause_id =@cause_reply.cause_comment.cause.id

    if @cause_reply.user == current_user
      @cause_reply.destroy
      flash[:notice] = "cause reply deleted"
    else
      flash[:notice] = "not sufficient permission"
    end
    
    redirect_to cause_path(:id => cause_id)
  end

def cause_reply_params
    params.require(:cause_reply).permit(:cause_comment_id, :user_id, :reply)
  end
end
