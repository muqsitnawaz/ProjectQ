class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  def show
    @interests = get_all_interests.sort!

    # Fetching questions depending upon query type
    if params[:id].nil?
      if params[:type] == 'asked'
        @questions = Question.where(:user_id => current_user.id)
      elsif params[:type] == 'answered'
        @questions = Question.where(:id => Answer.where(:user_id => current_user.id).map {|a| a.question_id})
      elsif params[:type] == 'following'
        @questions = Question.where(:id => current_user.following)
      else
        @questions = Question.all.order('updated_at DESC')
      end
    else
      @question = Question.find_by_id(params[:id])
    end
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to questions_path(:id => @question.id)
    else
      redirect_to root_path
    end
  end

  def edit
    @question = Question.find_by_id(params[:id])

  end

  def follow
    question_id = params[:question_id].to_i
    @user = User.find_by_email(current_user.email)
    if !@user.following.include? question_id
      @user.following << question_id
    end
    @user.save

    if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end

  def destroy
    @question = Question.find_by_id(params[:id])

    if @question.user == current_user
      @question.destroy
    end

    redirect_to root_path
  end

private
   def question_params
     params.require(:question).permit(:user_id, :content, :image, :detail, :topics => [])
   end
end
