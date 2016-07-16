Rails.application.routes.draw do
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
  resource :contests
  post '/update_contest' => 'contests#update'

  # ContestAnswers paths
  resource :contest_answers
  post '/mark_winner' => 'contest_answers#mark_winner'

  # Causes paths
  resource :causes
  post '/update_cause' => 'causes#update'
  post '/agree' => 'causes#agree'
  post '/disagree' => 'causes#disagree'
  post '/follow_cause' => 'causes#follow'

  # Causes comments paths
  resource :cause_comments
  post '/update_cause_comment' => 'cause_comments#update'

  get 'staticpages/login'
  get 'staticpages/signup'

  # Articles paths
  resource :articles
  patch "articles/:id" => "articles#update", as: "update_article"
  get "answer_article_request/:id" => "articles#answer", as: "answer_article_request"
  post "create_answer" => "articles#create_answer", as: "create_answer"

  # Article requests
  resources :article_requests


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
end
