class FeedsController < ApplicationController
	before_filter :authenticate_user!, except: [ :index, :public_profile ]

  def index
    if user_signed_in?
      @questions = Question.all.order('created_at DESC')
      matches = []

      @questions.each do |question|
        current_user.interests.each do |interest|
          if question.topics.include? interest
            matches << question
          end
        end
      end
      @questions = matches
    else
      @questions = Question.order('created_at DESC').limit(10)
    end
  end

  def notifications
    @notifications = Notification.where(:user_id => current_user.id).order('created_at DESC')
  end

  # User profile related methods
  def profile
  	@user = current_user

  	@degrees = get_all_degrees
  	@subjects = get_all_subjects
  	@location = @user.location
  end
  
  def public_profile
    @user = User.find_by_id(params[:id])
    @option = params[:option]
    
    if @user.nil?
      flash[:notice] = 'user not found'
      redirect_to root_path
    else
      if @option.nil?
        @items = Question.where(:id => Answer.where(:user_id => @user.id).map {|a| a.question_id})
      elsif @option == 'questions'
        @items = Question.where(:user_id => @user.id)
      elsif @option == 'contests'
        @items = Contest.where(:winner_id => @user.id)
      elsif @option == 'causes'
        @items = Cause.where(:user_id => @user.id)
      elsif @option == 'articles'
        @items = Article.where(:user_id => @user.id)
      end
      
      @items = @items.order('created_at DESC')
    end
  end

  # Helper methods
  def add_interest
  	@user = User.find_by_id(current_user.id)
  	if !@user.interests.include? params[:interest]
  		@user.interests << params[:interest]
  	end
  	@user.save
  	redirect_to profile_path
  end

  def add_education
  	education = {:degree => params[:degree], :subject => params[:subject], :school => params[:school]}

  	@user = User.find_by_id(current_user.id)
  	if !@user.education.include? education
  		@user.education << education
  	end
  	@user.save
  	redirect_to profile_path
  end

  def add_employment
  	employment = {:position => params[:position], :organization => params[:organization], :start => params[:start], :end => params[:end]}

  	@user = User.find_by_id(current_user.id)
  	if !@user.employments.include? employment
  		@user.employments << employment
  	end
  	@user.save
  	redirect_to profile_path
  end

  def update_location
  	@user = User.find_by_id(current_user.id)
  	@user.location = params[:location]
  	@user.save
  	redirect_to profile_path
  end
end
