Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users,:controllers => { :omniauth_callbacks => "callbacks" }

  # Feeds Controller
  root 'feeds#index'
  get '/profile' => 'feeds#profile', :as => 'profile'
  get '/profile/:id' => 'feeds#public_profile', :as => 'public_profile'
  
  get '/notifications' => 'feeds#notifications', :as => 'notifications'
  post '/add_interest' => 'feeds#add_interest'
  post '/add_education' => 'feeds#add_education'
  post '/add_employment' => 'feeds#add_employment'
  post '/update_location' => 'feeds#update_location'

  # Questions paths
  resources :questions
  post '/follow' => 'questions#follow'
  post '/update_question' => 'questions#update'

  # Answers paths
  resource :answers
  post '/update_answer' => 'answers#update'
  post '/upvote' => 'answers#upvote'
  post '/downvote' => 'answers#downvote'

  # Replies paths
  resource :replies
  post '/update_reply' => 'replies#update'

  # Contests paths
  resources :contests
  post '/update_contest' => 'contests#update'

  # ContestAnswers paths
  resource :contest_answers
  post '/mark_winner' => 'contest_answers#mark_winner'

  # Causes paths
  resources :causes
  post '/update_cause' => 'causes#update'
  post '/agree' => 'causes#agree'
  post '/disagree' => 'causes#disagree'
  post '/follow_cause' => 'causes#follow'

  # Causes comments paths
  resource :cause_comments
  post '/update_cause_comment' => 'cause_comments#update'

  resource :cause_replies
  post '/update_cause_reply' => 'cause_replies#update'

  # Articles paths
  resources :articles
  get "answer_article_request/:id" => "articles#answer", as: "answer_article_request"
  post "create_answer" => "articles#create_answer", as: "create_answer"

  # Article requests
  resources :article_requests

  get 'staticpages/login'
  get 'staticpages/signup'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
end
