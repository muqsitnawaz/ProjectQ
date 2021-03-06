class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :except => [:update_post]
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def is_admin?
    if user_signed_in?
      return current_user.is_admin
    else
      return false
    end
  end

  def get_all_degrees
    [
      'High School',
      'BSc/BA',
      'MSc/MA',
      'PhD'
    ]
  end

  def get_all_subjects
    [
      'Accounting',
    'Ancient History',
    'Antarctic Studies',
    'Anthropology',
    'Applied Psychology',
    'Art Curatorship',
    'Art History',
    'Art Theory',
    'Astronomy',
    'Biochemistry',
    'Bioengineering',
    'Biological Sciences',
    'Biosecurity',
    'Biotechnology',
    'Botany',
    'Business Administration',
    'Business Economics',
    'Business Management',
    'Cellular and Molecular Biology',
    'Chemical and Process Engineering',
    'Chemistry',
    'Child and Family Psychology',
    'Chinese',
    'Cinema Studies',
    'Civil Engineering',
    'Classical Studies',
    'Classics',
    'Clinical Psychology',
    'Clinical Teaching ',
    'Communication Disorders',
    'Computational and Applied Mathematics ',
    'Computer-Assisted Language Learning',
    'Computer Engineering',
    'Computer Science',
    'Construction Management ',
    'Counselling ',
    'Creative Writing ',
    'Criminal Justice',
    'Cultural Studies',
    'Development Studies ',
    'Digital Humanities ',
    'Diplomacy and International Relations ',
    'Early Childhood Teacher Education',
    'Earthquake Engineering ',
    'Ecology',
    'Economics',
    'Education',
    'e-Learning and Digital Technologies in Education ',
    'Electrical and Electronic Engineering',
    'Engineering',
    'Engineering Geology ',
    'Engineering Management ',
    'Engineering Mathematics ',
    'English',
    'English Language',
    'Environmental Science',
    'Ethics ',
    'European and European Union Studies',
    'European Union Studies ',
    'Evolutionary Biology ',
    'Film',
    'Finance',
    'Financial Engineering',
    'Fine Arts',
    'Fire Engineering ',
    'Forest Engineering',
    'Forestry',
    'French',
    'Freshwater Management ',
    'Geographic Information Science ',
    'Geography',
    'Geology',
    'German',
    'Graphic Design',
    'Hazard and Disaster Management ',
    'Health Sciences',
    'Higher Education ',
    'History',
    'Human Interface Technology ',
    'Human Resource Management',
    'Human Services',
    'Inclusive and Special Education ',
    'Industrial and Organisational Psychology ',
    'Information Systems',
    'International Business',
    'International Law and Politics ',
    'Japanese',
    'Journalism',
    'Law',
    'Leadership ',
    'Learning Support',
    'Linguistics',
    'Literacy ',
    'Management',
    'Management Science',
    'Marketing',
    'Mathematical Physics ',
    'Mathematics',
    'Mathematics and Philosophy ',
    'Mechanical Engineering',
    'Mechatronics Engineering',
    'Media and Communication',
    'Medical Physics ',
    'Microbiology ',
    'Music',
    'Natural Resources Engineering',
    'Operations and Supply Chain Management',
    'Pacific Studies',
    'Painting',
    'Palliative Care ',
    'Philosophy',
    'Photography',
    'Physical Education',
    'Physics',
    'Plant Biology ',
    'Political Science',
    'Primary Teacher Education',
    'Printmaking',
    'Professional Development ',
    'Psychology',
    'Public Safety',
    'Resilience and Sustainability',
    'Russian',
    'Science and Entrepreneurship',
    'Science Education',
    'Sculpture',
    'Seafood Sector: Management and Science ',
    'Secondary Teacher Education',
    'Social Work',
    'Sociology',
    'Software Engineering',
    'Soil Science',
    'South Asia Studies',
    'Spanish',
    'Specialist Teaching ',
    'Speech and Language Pathology,',
    'Speech and Language Sciences ',
    'Sport Coaching',
    'Statistics',
    'Strategic Leadership ',
    'Strategy and Entrepreneurship',
    'Taxation and Accounting',
    'Teacher Education',
    'Teaching and Learning ',
    'Tertiary Teaching ',
    'Transportation Engineering ',
    'Water Resource Management ',
    'Zoology'
    ]
  end
  
# Devise paths
def after_sign_in_path_for(resource)
  questions_path
end

def after_sign_out_path_for(resource)
  questions_path
end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :profile_pic, :password) }
  end
end
