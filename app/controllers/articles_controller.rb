require 'resque'
require_relative './workers/articles/article_request_article_notif'

class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]
  
  def index
    if params[:type].nil?
      @articles = Article.all.order('created_at DESC')
    else
      @articles = Article.all.order('created_at DESC').reject {|q| !q.topics.include? params[:topic]}
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    
    if @article.save
      redirect_to article_path(:id => @article.id)
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
      redirect_to article_path(:id => @article.id)
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

    redirect_to articles_path
  end

  def answer
    article_request_id = params[:id]
    @article_request = ArticleRequest.find_by_id(article_request_id)
    @articles = Article.where(:article_request_id => @article_request.id)
    @article = Article.new
  end

  def create_answer
    @article_request = ArticleRequest.find_by_id(params[:article][:article_request_id])
    @article = current_user.articles.build(article_params)
    @article.topics = @article_request.topics

    if @article.save
      flash[:notice] = 'article created'
      redirect_to article_path(:id => @article.id)
    else
      flash[:notice] = 'article creation failed'
      redirect_to root_path
    end
    
    # Generating notifcation
    Resque.enqueue(ArticleRequestArticleNotif, @article_request.id, current_user.id)
  end

private
  def article_params
    params.require(:article).permit(:article_request_id, :heading, :intro, :content, :topics => [])
  end
end
