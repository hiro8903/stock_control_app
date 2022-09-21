Rails.application.routes.draw do
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
    # 複数のリソースを指定できる。resources :deliverys を追加する予定。
  end
end
