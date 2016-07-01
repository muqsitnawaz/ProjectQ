class AnswersController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      redirect_to questions_path(:id => params[:answer][:question_id])
    else
      redirect_to root_path
    end
  end

  def update
    @answer = Answer.find_by_id(params[:answer_id])

    if !@answer.nil?
      @answer.answer = params[:answer]
      @answer.save

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
    @answer = Answer.find_by_id(params[:id])
    question_id =@answer.question.id

    if @answer.user == current_user
      @answer.destroy
      redirect_to questions_path(:id => question_id)
    else
      flash[:notice] = "not sufficient permission"
      redirect_to root_path
    end
  end

  # Upvoting an answer
  def upvote
    @answer = Answer.find_by_id(params[:answer_id].to_i)
    @answer.upvotes += 1
    @answer.save

    if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end

  # Downvoting an answer
  def downvote
    @answer = Answer.find_by_id(params[:answer_id].to_i)
    @answer.downvotes += 1
    @answer.save

    if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end

private
  def answer_params
    params.require(:answer).permit(:question_id, :user_id, :answer, :image, :upvotes, :downvotes)
  end
end
