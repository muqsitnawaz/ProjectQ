class QuestionsController < ApplicationController
 # before_filter :authenticate_user!, except: [:index, :show, :search ]
  
  def index
    # if params[:topic].nil?
    #   if user_signed_in? && !params[:type].nil?
    #     if params[:type] == 'asked'
    #       @questions = Question.where(:user_id => current_user.id).order('created_at DESC')
    #     elsif params[:type] == 'answered'
    #       @questions = Question.where(:id => Answer.where(:user_id => current_user.id).map {|a| a.question_id}).order('created_at DESC')
    #     elsif params[:type] == 'following'
    #       @questions = Question.where(:id => current_user.following).order('created_at DESC')
    #       @questionasked = Question.where(:user_id => current_user.id).order('created_at DESC')
    #       @questionans = Question.where(:id => Answer.where(:user_id => current_user.id).map {|a| a.question_id}).order('created_at DESC')
    #     end
    #   else
    #     @questions = Question.all.order('created_at DESC')
    #   end
    # else
    #   @questions = Question.all.order('created_at DESC').reject {|q| !q.topics.include? params[:topic]}
    # end
    if params[:topic].nil?
      if user_signed_in?
        @decider = 1;
        @questions = Question.all.order('created_at DESC').page(params[:page]).per(3) 
        # Question.where(:id => current_user.following).order('created_at DESC').page(params[:question_followed]).per(1)
        @questionasked = Question.where(:user_id => current_user.id).order('created_at DESC').page(params[:question_asked]).per(1)
        @questionans = Question.where(:id => Answer.where(:user_id => current_user.id).map {|a| a.question_id}).order('created_at DESC').page(params[:question_ans]).per(1)
      else
        @questions = Question.all.order('created_at DESC').page(params[:page]).per(3)
      end
    else
      @decider = 0
      @questions = Question.all.order('created_at DESC').reject {|q| !q.topics.include? params[:topic]}
    end
  end
  
  def show
    puts params[:id]
    @question = Question.find_by_content(params[:id])  #change it later
    if @question.nil?
      flash[:notice] = 'question not found'
      redirect_to questions_path
    end
  end
  
  def search
    puts params[:query]
    @query = params[:query]
    
    @items = []
    questions = Question.search(@query)
    contests = Contest.search(@query)
    causes = Cause.search(@query)
    articles = Article.search(@query)
    
    (@items << questions).flatten!
    (@items << contests).flatten!
    (@items << causes).flatten!
    (@items << articles).flatten!
  end
  
  def create
    @question = current_user.questions.build(question_params)
    @question.content = @question.content.parameterize
    if @question.save
      flash[:notice] = 'question created'
      redirect_to question_path(:id => @question.id)
    else
      flash[:notice] = 'question creation failed'
      redirect_to questions_path
    end
  end

  def update
    @question = Question.find_by_id(params[:question_id])

    if !@question.nil?
      @question.content = params[:question_content]
      @question.detail = params[:question_detail]
      @question.save

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
    @question = Question.find_by_id(params[:id])

    if @question.user == current_user
      @question.destroy
      flash[:notice] = 'question deleted'
    else 
      flash[:notice] = 'not sufficient permission'
    end

    redirect_to questions_path
  end

  # Custom methods
  def follow
    question_id = params[:question_id].to_i

    # Getting models
    @user = User.find_by_email(current_user.email)
    @question = Question.find_by_id(question_id)

    # Adding follow details
    if !@user.following.include? question_id
      @user.following << question_id
    end
    @user.save

    if !@question.nil? 
      if !@question.followers.include? @user.id
        @question.followers << @user.id
        @question.save
      end
    end

    if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end
#import questions temp
  def import
    if (Question.import(params[:file]))
    redirect_to root_path, notice: " imported."
  end
  end
private
  def question_params
    params.require(:question).permit(:user_id, :content, :detail, :anonymous, :topics => [])
  end
end
