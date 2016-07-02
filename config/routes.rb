Rails.application.routes.draw do
  devise_for :users,:controllers => { :omniauth_callbacks => "callbacks" }

  # Feeds Controller
  root 'feeds#index'
  get '/profile' => 'feeds#profile', :as => 'profile'
  get '/notifications' => 'feeds#notifications', :as => 'notifications'
  post '/add_interest' => 'feeds#add_interest'
  post '/add_education' => 'feeds#add_education'
  post '/add_employment' => 'feeds#add_employment'
  post '/update_location' => 'feeds#update_location'

  # Questions paths
  resource :questions
  post '/follow' => 'questions#follow'
  post '/update_question' => 'questions#update'

  # Contests paths
  resource :contests
  post '/update_contest' => 'contests#update'

  # Answers paths
  resource :answers
  post '/update_answer' => 'answers#update'
  post '/upvote' => 'answers#upvote'
  post '/downvote' => 'answers#downvote'

  # ContestAnswers paths
  resource :contest_answers
  post '/mark_winner' => 'contest_answers#mark_winner'

  # Replies paths
  resource :replies
  post '/update_reply' => 'replies#update'

  get 'staticpages/login'
  get 'staticpages/signup'


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
