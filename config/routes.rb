Rails.application.routes.draw do
  get 'departments/new'
  root 'sessions#new'

  # ログイン機能
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
