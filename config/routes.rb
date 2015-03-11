Rails.application.routes.draw do
  
  root             'static_pages#home'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    resources :followings, :followers
  end
  resources :relationships,       only: [:create, :destroy]
  resources :categories, only: [:index]
  resources :words, only: [:index, :edit, :update, :destroy]
  resources :lessons
  resources :results

  resources :categories, only: [:new, :create, :edit, :update, :destroy] do
    resources :words, only: [:new, :create]
  end  
end