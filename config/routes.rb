Rails.application.routes.draw do

  root 'static_pages#home'

  get 'index' => 'posts#index'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users, only: [:new, :create, :show]
  resources :posts,  only: [:new, :create, :show, :index, :destroy]
  resources :comments, only: [:create]

end
