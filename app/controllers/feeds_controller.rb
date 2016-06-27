class FeedsController < ApplicationController
	before_filter :authenticate_user!, except: [ :index ]

  def index
    @interests = get_all_interests.sort!
  end

  def newsfeed
    @interests = get_all_interests.sort!
    @questions = Question.all
    @matches = []

    @questions.each do |question|
      current_user.interests.each do |interest|
        if question.topics.include? interest
          @matches << question
        end
      end
    end
  end

  # User profile related methods
  def profile
  	@user = current_user

  	@interests = get_all_interests.sort!

  	@degrees = get_all_degrees
  	@subjects = get_all_subjects
  	@location = @user.location
  end

  def add_interest
  	@user = User.find_by_email(current_user.email)
  	if !@user.interests.include? params[:interest]
  		@user.interests << params[:interest]
  	end
  	@user.save
  	redirect_to profile_path
  end

  def add_education
  	education = {:degree => params[:degree], :subject => params[:subject], :school => params[:school]}

  	@user = User.find_by_email(current_user.email)
  	if !@user.education.include? education
  		@user.education << education
  	end
  	@user.save
  	redirect_to profile_path
  end

  def add_employment
  	employment = {:position => params[:position], :organization => params[:organization], :start => params[:start], :end => params[:end]}

  	@user = User.find_by_email(current_user.email)
  	if !@user.employments.include? employment
  		@user.employments << employment
  	end
  	@user.save
  	redirect_to profile_path
  end

  def update_location
  	@user = User.find_by_email(current_user.email)
  	@user.location = params[:location]
  	@user.save
  	redirect_to profile_path
  end
end
