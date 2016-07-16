class ArticleRequestsController < ApplicationController
  before_filter :authenticate_user!, except: [ :show ]

  def index
    @article_requests = ArticleRequest.all.order('created_at DESC')
  end

  def new
    @article_request = ArticleRequest.new
  end

  def create
    @article_request = current_user.article_requests.build(article_request_params)
    
    if @article_request.save
      redirect_to article_request_path(:id => @article_request.id)
      flash[:notice] = 'article request created'
    else
      flash[:notice] = 'article request creation failed'
      redirect_to root_path
    end
  end

  def show
    @article_request = ArticleRequest.find_by_id(params[:id])
    @articles = Article.where(:article_request_id => @article_request.id).order('created_at DESC')

    if @article_request.nil?
      flash[:notice] = 'article request not found'
      redirect_to root_path
    end
  end

  def destroy
    @article_request = ArticleRequest.find_by_id(params[:id])

    if @article_request.user == current_user
      @article_request.destroy
      flash[:notice] = 'article request deleted'
    else
      flash[:notice] = 'not sufficient permission'
    end

    redirect_to root_path
  end

private
  def article_request_params
    params.require(:article_request).permit(:heading, :explanation, :topics => [])
  end
end
