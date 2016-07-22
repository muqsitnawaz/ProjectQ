module ApplicationHelper
  def is_admin?
    if user_signed_in?
      return current_user.is_admin
    else
      return false
    end
  end
  
  # Devise helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def resource_class
    devise_mapping.to
  end
  
  def get_pretty_provider_name(provider)
    if (provider == 'GoogleOauth2')
      return '<i class="fa fa-3x fa-google-plus-official" style="color: #D62D20;" aria-hidden="true"></i>'
    elsif (provider == 'Facebook')
      return '<i class="fa fa-3x fa-facebook-square" style="color: #3B5998;" aria-hidden="true"></i>'
    elsif (provider == 'Twitter') 
      return '<i class="fa fa-3x fa-twitter-square" style="color: #326ADA;" aria-hidden="true"></i>'
    end
  end

  # Cause helper methods
  def get_all_cause_types
    [
      'Raise funds',
      'Spread awareness about something',
      'Protest against something',
      'Draw world\'s attention'
    ]
  end

  # Question helper methods
  def get_all_interests
    [
      'Technology',
    'Science',
    'Books',
    'Business',
    'Movies',
    'Health',
    'Visiting and Travel',
    'Music',
    'Education',
    'Food',
    'Psychology',
    'Design',
    'History',
    'Economics',
    'Cooking',
    'Entertainment',
    'Writing',
    'Sports',
    'Photography',
    'Philosophy',
    'Marketing',
    'Finance',
    'Mathematics',
    'Fashion and Style',
    'Politics',
    'Literature',
    'Computer Science',
    'Television Series',
    'Startups',
    'Fine Art',
    'Physics',
    'Entrepreneurship',
    'Google',
    'Journalism',
    'Investing',
    'Healthy Eating',
    'Software Engineering',
    'India',
    'Mobile Phones',
    'Computer Programming',
    'Medicine and Healthcare',
    'Nutrition',
    'Money',
    'Current Events in Technology',
    'Dating and Relationships',
    'Silicon Valley',
    'Writers and Authors',
    'Business Strategy',
    'Novels',
    'Small Businesses'
    ]
  end
end
