Rails.application.routes.draw do
  root 'sessions#new'

  # ログイン機能
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :departments
  resources :manufacturers
  resources :suppliers
end
