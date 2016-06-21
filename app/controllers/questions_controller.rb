class QuestionsController < ApplicationController
  def index
    #all the questions asked by the user will be handled here
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to(controller: 'questions',action: 'template',id: @question.id, content: @question.content)
      #take him to the page where he can see his question
    else
      redirect_to feeds_index_path
    end
  end

  def new

  end

  def edit
    #allow user to edit his question
  end

  def template
    @question = Question.find(params[:id])
  end
  private

   def question_params
     params.require(:question).permit(:content, :image , :user_id, :detail)
   end
end
