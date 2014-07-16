Wplay::Application.routes.draw do
 
  devise_for :gods
  devise_for :admins
  devise_for :workers

  mount RailsAdmin::Engine => '/adminka', as: 'rails_admin'

  match "/control", to: "control#get_coins", as: "control_index", via: :get
  get "control/invite"
  post "control/invited"
  post "control/coin_worker/:id", to: "control#coin_worker", as: "control_coin_worker"
  post "control/achieve_worker/:id", to: "control#achieve_worker", as: "control_achieve_worker"

  get "control/completed_quests"
  get "control/accept_quest/:id", to: "control#accept_quest", as: "control_accept_quest"
  
  get "/workers/sign_in_token", to: "workers#sign_in_token", as: "sign_in_token", via: :get
  get "/workers/test_sign_in", to: "workers#test_sign_in", as: "test_sign_in", via: :get
  get "/rating", to: "board#rating", as: "rating"
  get "/profile/edit", to: "workers#edit", as: "edit"
  patch "/profile/update", to: "workers#update", as: "update"

  get "/login", to: "board#login", as: "custom_login"
  get "/register", to: "board#register", as: "custom_register"
  post "/registered", to: "board#registered", as: "done_register"

  resources :workers
  resources :quests do
    get :get, on: :member
    get :assigned, on: :collection
  end

  resources :assignments do
    get :iterate, on: :member
  end

  # ADMIN CONTROL
  resource :control do
    resources :departments, :controller => 'control/departments'
    resources :quests, :controller => 'control/quests'
    resources :achievements, :controller => 'control/achievements'
  end

  root to: "board#index"
end
