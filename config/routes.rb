Wplay::Application.routes.draw do
 
  get "actions/add"
  get "workers/show"
  devise_for :workers
  devise_for :admins

  mount RailsAdmin::Engine => '/adminka', as: 'rails_admin'

  match "/control", to: "control#index", as: "control_index", via: :get
  get "profile", to: "workers#profile", as: "profile"
  get "control/invite"
  post "control/invited"
  post "control/update_worker/:id", to: "control#update_worker", as: "control_update_worker"
  get "/workers/sign_in_token", to: "workers#sign_in_token", as: "sign_in_token", via: :get

  resources :workers

  root to: "board#index"
end
