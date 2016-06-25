Rails.application.routes.draw do
  devise_for :users,:controllers => { :omniauth_callbacks => "callbacks" }
  
  # Feeds Controller
  root 'feeds#index'
  get '/profile' => 'feeds#profile', :as => 'profile'
  post '/add_interest' => 'feeds#add_interest'
  post '/add_education' => 'feeds#add_education'

  get 'staticpages/login'
  get 'staticpages/signup'
  
  resource :questions
  get 'questions/template/:content' => 'questions#template'
  
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
