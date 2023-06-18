Rails.application.routes.draw do
  get 'arrivals/index_all', to: 'arrivals#index_all'
  get 'answers/index'
  get 'answers/show'
  get 'answers/new'
  get 'answers/edit'
  root 'sessions#new'

  # LINEログイン
  get 'line_login_api/login', to: 'line_login_api#login'
  get 'line_login_api/callback', to: 'line_login_api#callback'
  
  # ログイン機能
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users
  resources :departments
  resources :manufacturers
  resources :suppliers
  resources :paints
  resources :orders, shallow: true do
    resources :answers # :shallowオプションを使うことで、ルーティングの記述を複雑にせず、かつ深いネストを作らない。
    resources :arrivals
  end
  resources :inventories
  resources :all_inventories
  resources :withdraws
  resources :stocks, only: [:index, :show]
end
