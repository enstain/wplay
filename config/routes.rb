Wplay::Application.routes.draw do
 
  get "control" to: "control#index" as: "control_index"
  get "control/invite"
  devise_for :workers
  devise_for :admins
  mount RailsAdmin::Engine => '/adminka', as: 'rails_admin'

  root to: "board#index"
end
