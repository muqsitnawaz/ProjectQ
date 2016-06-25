class QuestionsController < ApplicationController
  def show
    # Fetching questions depending upon query type
    if params[:type] == 'asked'
      @questions = Question.where(:user_id => current_user.id)
    elsif params[:type] == 'answered'

    elsif params[:type] == 'following'
      @questions = Question.where(:id => current_user.following)
    else
      @questions = Question.all.order('updated_at DESC')
    end
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to(controller: 'questions',action: 'template',id: @question.id, content: @question.content)
    else
      redirect_to feeds_index_path
    end
  end

  def new

  end

  def edit
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

  def template
    @question = Question.find(params[:id])
  end
private

   def question_params
     params.require(:question).permit(:content, :image , :user_id, :detail)
   end
end
