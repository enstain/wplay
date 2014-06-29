Wplay::Application.routes.draw do
 
  devise_for :workers
  devise_for :admins
  mount RailsAdmin::Engine => '/adminka', as: 'rails_admin'

  get "control", to: "control#index", as: "control_index"
  get "control/invite"

  root to: "board#index"
end
