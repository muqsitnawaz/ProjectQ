class FeedsController < ApplicationController
	before_filter :authenticate_user!, except: [ :index, :public_profile ]

  def index
    puts 'coming here'
    if user_signed_in? && (!current_user.interests.empty? || !current_user.knows_about.empty?)
      @questions = Question.all.order('created_at DESC')
      topics = current_user.interests.clone
      (topics << current_user.knows_about).flatten!
      matches = []

      @questions.each do |question|
        topics.each do |topic|
          if question.topics.include? topic
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
    current_user.read = true
    current_user.save
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
    # @option = params[:option]
   
    puts 'this is the  option param'
    # puts @option
    if @user.nil?
      flash[:notice] = 'user not found'
      redirect_to questions_path
    else
      # if @option.nil?
        @items = Question.where(:user_id => @user.id) 
        puts @items
        @itemsCo = Contest.where(:winner_id => @user.id)
        @itemsCa = Cause.where(:user_id => @user.id)
        @itemsA = Article.where(:user_id => @user.id)
      # end
      @user.profile_views += 1
      @user.save
    end
  end

  # Helper methods
  def add_know_about
  	@user = User.find_by_id(current_user.id)
  	@user.knows_about = params[:new_topics]
  	@user.save
  	
  	if request.xhr?
      render :json => {
        :status => "success"
      }
    end
  end
  
  def add_interest
  	@user = User.find_by_id(current_user.id)
  	@user.interests = params[:new_interests]
  	@user.save
  	
  	if request.xhr?
      render :json => {
        :status => "success"
      }
    end
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
  
  def update_profile_pic
    @user = User.find_by_id(current_user.id)
    @user.update_attributes! profile_params_for_pic
    @user.save
  	redirect_to profile_path
  end
  
  def mark_as_complete
    @user = User.find_by_id(current_user.id)
    
    if !@user.knows_about.empty? && !@user.interests.empty? && !@user.education.empty? &&
    !@user.profile_pic.nil? && !@user.employments.empty? && !@user.location.nil?
      @user.completed = true
      @user.save
    end
    
    redirect_to profile_path
  end
  
private
  def profile_params_for_pic
    params.require(:user).permit(:profile_pic)
  end
end
