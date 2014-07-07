class BoardController < ApplicationController

  def index
  	@actions = Action.all.order_by(c_at: -1)
  end

  def rating
  	if params[:department]
  	  @department = Department.where(id: params[:department]).first
  	  if @department
  	  	@workers = Worker.where(department: @department).order_by(xp: -1)
  	  else
  	  	redirect_to rating_path
  	  end
  	else
  	  @workers = Worker.all.order_by(xp: -1)
  	end
  end

end
