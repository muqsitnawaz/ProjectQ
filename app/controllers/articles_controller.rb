class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path(:id => @article.id)
      flash[:notice] = 'article created'
    else
      flash[:notice] = 'article creation failed'
      redirect_to root_path
    end
  end

  def show
    @article = Article.find_by_id(params[:id])

    if @article.article_request_id != -1
      @article_request = ArticleRequest.find_by_id(@article.article_request_id)
    end

    if @article.nil?
      flash[:notice] = 'article not found'
      redirect_to root_path
    end
  end

  def edit
    @article = Article.find_by_id(params[:id])

    if @article.nil?
      flash[:notice] = 'article not found'
      redirect_to root_path
    end
  end

  def update
    @article = Article.find_by_id(params[:article][:id])

    if @article.update(article_params)
      redirect_to articles_path(:id => @article.id)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find_by_id(params[:id])

    if @article.user == current_user
      @article.destroy
      flash[:notice] = 'article deleted'
    else
      flash[:notice] = 'not sufficient permission'
    end

    redirect_to root_path
  end

  def answer
    article_request_id = params[:id]
    @article_request = ArticleRequest.find_by_id(article_request_id)
    @article = Article.new
  end

  def create_answer
    @article_request = ArticleRequest.find_by_id(params[:article][:article_request_id])
    @article = current_user.articles.build(article_params)
    @article.topics = @article_request.topics

    if @article.save
      redirect_to articles_path(:id => @article.id)
      flash[:notice] = 'article created'
    else
      flash[:notice] = 'article creation failed'
      redirect_to root_path
    end
  end

private
  def article_params
    params.require(:article).permit(:article_request_id, :heading, :intro, :content, :topics => [])
  end
end
