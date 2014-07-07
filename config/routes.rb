Wplay::Application.routes.draw do
 
  get "actions/add"
  get "workers/show"
  devise_for :workers
  devise_for :admins

  mount RailsAdmin::Engine => '/adminka', as: 'rails_admin'

  match "/control", to: "control#index", as: "control_index", via: :get
  get "control/invite"
  post "control/invited"
  post "control/update_worker/:id", to: "control#update_worker", as: "control_update_worker"
  
  get "/workers/sign_in_token", to: "workers#sign_in_token", as: "sign_in_token", via: :get
  get "/workers/test_sign_in", to: "workers#test_sign_in", as: "test_sign_in", via: :get
  #get "/workers/:id", to: "workers#profile", as: "profile"
  get "/profile/edit", to: "workers#edit", as: "edit"
  patch "/profile/update", to: "workers#update", as: "update"



  resources :workers

  root to: "board#index"
end
