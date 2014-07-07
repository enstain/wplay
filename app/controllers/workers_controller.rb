class WorkersController < ApplicationController
  include Devise::Controllers::Helpers

  before_action :authenticate_worker!, only: [:profile, :edit, :update]

  def show
  	@worker = Worker.find(params[:id])

    #if worker_signed_in?
    #  redirect_to profile_path if current_worker == @worker
    #end
  end

  #def profile
  #	@worker = Worker.find(current_worker)
  #	render "show"
  #end

  def edit
    @worker = Worker.find(current_worker)
  end

  def update
    params.permit!
    @worker = Worker.find(current_worker)

    respond_to do |format|
      if @worker.update_attributes(params[:worker])
        format.html { redirect_to profile_path, notice: 'Профиль обновлён' }
      else
        flash[:error] = @worker.errors.full_messages.join("\n")
        format.html { render action: "edit" }
      end
    end
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

  def test_sign_in
    if Rails.env.development?
      worker = Worker.first
      sign_out(current_admin) if admin_signed_in?
      sign_out(current_worker) if worker_signed_in?
      sign_in_and_redirect worker
    end
  end
  
end
