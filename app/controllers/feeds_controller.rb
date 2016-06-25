class FeedsController < ApplicationController
	before_filter :authenticate_user!, only: [ :profile ]

  def index
  end

  def profile
  	@user = current_user
  	
  	@interests = get_all_interests.sort!

  	@degrees = get_all_degrees
  	@subjects = get_all_subjects
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
  	puts "adding education"
  	puts params

  	@user = User.find_by_email(current_user.email)
  	@user.education << {:degree => params[:degree], :subject => params[:subject], :school => params[:school]}
  	@user.save
  	redirect_to profile_path
  end

  def add_employment
  	puts "adding employment"
  	@user = User.find_by_email(current_user.email)
  	@user.employments << {:position => params[:position], :organization => params[:organization], :start => params[:start], :end => params[:end]}
  	@user.save
  	redirect_to profile_path
  end
end
