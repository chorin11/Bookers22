Rails.application.routes.draw do
  get 'home/about' => 'home#about'

  root "home#top"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users

  resources :books
  resources :users, only: [:index, :create, :update, :show, :edit]
end
