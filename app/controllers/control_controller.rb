class ControlController < ApplicationController

  before_action :authenticate_admin!

  def index
  	@workers = Worker.company(current_company).all.order_by(id: 1)
  end

  def invite
  	@worker = Worker.new
  end

  def invited
    params.permit!
  	@worker = Worker.create(params[:worker])
    @worker.company = current_company
    
      if @worker.save
        flash[:notice] = 'Сотрудник успешно приглашён'
        Action.create(action_object: @worker, type: :new_user, company: current_company)
        ContactMailer.welcome_email(@worker).deliver!
        redirect_to control_invite_path
      else
        flash[:error] = @worker.errors.full_messages.join("\n")
      	render "invite"
      end
  end

  def update_worker
    @worker = Worker.find(params[:id])
    @acoins = params[:add_coins].to_i
    @worker.coins += @acoins
    @worker.raise_xp(@acoins)

    if @worker.save
       flash[:notice] = 'Сохранено'
       Action.create(action_object: @worker, type: :user_get_coins, tie: ApplicationController.helpers.coiner(@acoins), company: current_company)
       redirect_to control_index_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to control_index_path()
    end
  end

  def new_quest
    @quest = Quest.new
  end

  def create_quest
    params.permit!
    @quest = Quest.create(params[:quest])
    @quest.company = current_company
    
      if @quest.save
        flash[:notice] = 'Квест добавлен'
        Action.create(action_object: @quest, type: :new_quest, company: current_company)
        redirect_to control_new_quest_path
      else
        flash[:error] = @worker.errors.full_messages.join("\n")
        render "new_quest"
      end
  end
  
end
