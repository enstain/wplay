class WorkersController < ApplicationController
  def show
  	@worker = Worker.find(params[:id])
  end

  def profile
  	@worker = Worker.find(current_worker)
  	render "show"
  end
end
