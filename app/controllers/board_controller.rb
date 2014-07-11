class BoardController < ApplicationController

  def index
  	@actions = Action.company(current_company).all.order_by(c_at: -1)
  end

  def login
    @im_at_login_page = true
    if current_company
      redirect_to root_path()
    end
  end

  def rating
  	if params[:department]
  	  @department = Department.company(current_company).where(id: params[:department]).first
  	  if @department
  	  	@workers = Worker.company(current_company).where(department: @department).order_by(xp: -1)
  	  else
  	  	redirect_to rating_path
  	  end
  	else
  	  @workers = Worker.company(current_company).all.order_by(xp: -1)
  	end
  end

end
