class ControlController < ApplicationController

  before_action :authenticate_admin!
  before_action :admin_page

  def get_coins
  	@workers = Worker.company(current_company).all.order_by(id: 1)
    @achieves = Achievement.company(current_company).all
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

  def coin_worker
    @worker = Worker.find(params[:id])
    @acoins = params[:add_coins].to_i
    if @acoins > 0
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
    else
      redirect_to control_index_path()
    end
  end

  def achieve_worker
    @worker = Worker.find(params[:id])
    @achieve = Achievement.find(params[:achievement])
    if @achieve
      @gaven = GavenAchievement.where(achievement: @achieve, worker: @worker).first
      if @gaven
        @gaven.count+=1
      else
        @gaven = GavenAchievement.create(achievement_id: @achieve.id, worker_id: @worker.id)
      end
      if @gaven.save
         flash[:notice] = 'Сохранено'
         Action.create(action_object: @worker, type: :user_get_achieve, tie: @achieve.name, company: current_company)
         redirect_to control_index_path()
      else
         flash[:error] = 'Ошибка'
         redirect_to control_index_path()
      end
    else
      redirect_to control_index_path()
    end
  end

  def completed_quests
    @completed = Assignment.completed("non_checked")
  end

  def accept_quest
    @assignment = Assignment.find(params[:id])
    if !@assignment.check_complete
      @assignment.check_complete = true
      @assignment.save

      @worker = @assignment.worker
      @acoins = @assignment.quest.reward
      @worker.coins += @acoins
      @worker.raise_xp(@acoins)
      Action.create(action_object: @worker, type: :user_get_coins, tie: ApplicationController.helpers.coiner(@acoins)+" за выполненный квест &laquo;#{@assignment.quest.name}&raquo;", company: @worker.company)
      @worker.save
    end
    redirect_to control_completed_quests_path()
  end

  private
  def admin_page 
    @admin_page = true
  end
  
end
