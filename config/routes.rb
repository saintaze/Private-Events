Rails.application.routes.draw do
  root                           "static_pages#home"
  
  get       '/contact',      to: 'static_pages#contact'
  get       '/about',        to: 'static_pages#about'
  
  get       '/signup',       to: 'users#new'
  # get       '/login',        to: 'sessions#new'
  # post      '/login',        to: 'sessions#create' 
  # delete    '/logout',       to: 'sessions#destroy' 

  resources :users,          only: [:create, :show]   
  # resources :posts,          only: [:index, :new, :create, :destroy] 

  # CATCH ALL, the name unmatched_route is just random name * suppodesly captures all the domanin and then any thing after that and this must be last route in file
  match '*unmatched_route', :to => 'application#page_not_found', via: [:get, :post]


end
