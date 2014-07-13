class BoardController < ApplicationController

  before_action :dont_need_subdomain, only: [:login]

  def index
  	@actions = Action.company(current_company).all.order_by(c_at: -1)
  end

  def login
    @im_at_login_page = true
  end

  def register
    @im_at_login_page = true
    
    @company = Company.new
    @company.admins.build
  end

  def registered
    @im_at_login_page = true
    params.permit!
    @company = Company.create(params[:company])

      if @company.save
        @admin = @company.admins.first
        ContactMailer.welcome_company_email(@admin).deliver
        redirect_to custom_login_path(subdomain: false)
      else
        flash.now[:error] = "При регистрации возникли следующие ошибки (проверьте примечания у полей, выделенных красным):"
        render action: "register" 
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

  private
  def dont_need_subdomain
    if current_company
      redirect_to root_path()
    end
  end

end
