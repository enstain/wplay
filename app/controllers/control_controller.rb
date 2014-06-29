class ControlController < ApplicationController

  before_action :authenticate_admin!

  def index
  	@workers = Worker.all.order_by(id: 1)
  end

  def invite
  	@worker = Worker.new
  end

  def invited
    params.permit!
  	@worker = Worker.create(params[:worker])
    
      if @worker.save
        flash[:notice] = 'Сотрудник успешно приглашён'
        @link = ActionController::Base.helpers.link_to @worker.name, worker_path(@worker)
        Action.create(content: "Сотрудник #{@link} был приглашён на сайт администратором")
        redirect_to control_invite_path
      else
        flash[:error] = @worker.errors.full_messages.join("\n")
      	redirect_to control_invite_path
      end
  end

  def update_worker
    @worker = Worker.find(params[:id])
    @acoins = params[:add_coins].to_i
    @worker.coins += @acoins

    if @worker.save
       flash[:notice] = 'Сохранено'
       @link = ActionController::Base.helpers.link_to @worker.name, worker_path(@worker)
       Action.create(content: "Сотрудник #{@link} получил #{ApplicationController.helpers.coiner(@acoins)}")
       redirect_to control_index_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to control_index_path()
    end
  end
  
end
