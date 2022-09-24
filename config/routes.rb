Rails.application.routes.draw do
  get 'arrivals/index_all', to: 'arrivals#index_all'
  get 'answers/index'
  get 'answers/show'
  get 'answers/new'
  get 'answers/edit'
  root 'sessions#new'

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
end
