Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  # Feeds Controller
  root 'feeds#index'
  get '/profile' => 'feeds#profile', :as => 'profile'
  get '/profile/:id' => 'feeds#public_profile', :as => 'public_profile'
  
  get '/notifications' => 'feeds#notifications', :as => 'notifications'
  post '/add_know_about' => 'feeds#add_know_about'
  post '/add_interest' => 'feeds#add_interest'
  post '/add_education' => 'feeds#add_education'
  post '/add_employment' => 'feeds#add_employment'
  post '/update_location' => 'feeds#update_location'
  patch '/update_profile_pic' => 'feeds#update_profile_pic'
  post '/mark_as_complete' => 'feeds#mark_as_complete'

  # Questions paths
  resources :questions
  post '/follow' => 'questions#follow'
  post '/update_question' => 'questions#update'
  get '/search' => 'questions#search'

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
  
  get '/causes/petition/:id' => 'causes#petition'
  get '/causes/pledge/:id' => 'causes#pledge'
  patch '/pledge', to: 'causes#pledge_update', as: 'causes/pledge/update'
  patch '/petition', to: 'causes#petition_update', as: 'causes/petition/update'
  patch 'causes/update_pledge/:cause_id', to: 'causes#update_pledge', as: 'causes_update_pledge'
  patch 'causes/update_petition/:cause_id', to: 'causes#update_petition', as: 'causes_update_petition'
  patch 'causes/update_image/:cause_id', to: 'causes#image_upload', as: 'causes_image_upload'
  # to edit the pledge
  get 'causes/edit_pledge/:cause_id' => 'causes#edit_pledge', as: "causes_edit_pledge"
  # edit petition
  get 'causes/edit_petition/:cause_id' => 'causes#edit_petition', as: "causes_edit_petition"
  #for causes image
  get 'causes/final_view/:cause_id' => 'causes#completed_cause', as: "cause_completed"
  # to view the cause pledged
  get 'view_cause_pledged/:cause_id' => 'causes#pledge_view'
  get 'view_cause_petition/:cause_id' => 'causes#petition_view'
  
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
