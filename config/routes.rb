Wplay::Application.routes.draw do
 
  devise_for :gods
  devise_for :admins
  devise_for :workers

  mount RailsAdmin::Engine => '/adminka', as: 'rails_admin'

  #get "quests/show"
  #get "actions/add"
  #get "workers/show"

  match "/control", to: "control#index", as: "control_index", via: :get
  get "control/invite"
  post "control/invited"
  get "control/new_quest"
  post "control/create_quest"
  post "control/update_worker/:id", to: "control#update_worker", as: "control_update_worker"
  
  get "/workers/sign_in_token", to: "workers#sign_in_token", as: "sign_in_token", via: :get
  get "/workers/test_sign_in", to: "workers#test_sign_in", as: "test_sign_in", via: :get
  get "/rating", to: "board#rating", as: "rating"
  get "/profile/edit", to: "workers#edit", as: "edit"
  patch "/profile/update", to: "workers#update", as: "update"

  get "/login", to: "board#login", as: "custom_login"
  get "/register", to: "board#register", as: "custom_register"
  post "/registered", to: "board#registered", as: "done_register"

  resources :workers
  resources :quests

  get "/quests/get/:id", to: "quests#get", as: "quests_get"

  root to: "board#index"
end
