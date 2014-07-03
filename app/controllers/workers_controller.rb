class WorkersController < ApplicationController
  include Devise::Controllers::Helpers

  def show
  	@worker = Worker.find(params[:id])
  end

  def profile
  	@worker = Worker.find(current_worker)
  	render "show"
  end

  def sign_in_token
  	user_token = params[:user_token].presence
    worker       = user_token && Worker.find_by(authentication_token: user_token.to_s)
 
    if (worker && (Time.now - worker.c_at).to_i > 0)
      sign_out(current_admin) if admin_signed_in?
      sign_out(current_worker) if worker_signed_in?
      flash[:notice] = "Вы успешно вошли на сайт"
      sign_in_and_redirect worker
    end
  end
end
