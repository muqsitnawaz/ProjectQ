module ApplicationHelper
  def is_admin?
    if user_signed_in?
      return current_user.is_admin
    else
      return false
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
