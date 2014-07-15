class ControlController < ApplicationController

  before_action :authenticate_admin!
  before_action :admin_page

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

  def new_quest
    @quest = Quest.new
  end

  def create_quest
    params.permit!
    @quest = Quest.create(params[:quest])
    @quest.company = current_company
    
      if @quest.save
        flash[:notice] = 'Квест добавлен'
        Action.create(action_object: @quest, type: :new_quest, company: current_company, tie: ApplicationController.helpers.quest_for(@quest))
        redirect_to control_new_quest_path
      else
        flash[:error] = @quest.errors.full_messages.join("\n")
        render "new_quest"
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
      Action.create(action_object: @worker, type: :user_get_coins, tie: ApplicationController.helpers.coiner(@acoins)+" за выполненный квест &laquo;#{@assignment.quest.name}&raquo;", company: current_company)
      @worker.save
    end
    redirect_to control_completed_quests_path()
  end

  def departments
    @department_page = true
    @departments = Department.company(current_company).all
  end

  def new_department
    @department = Department.new
  end

  def create_department
    params.permit!
    @department = Department.create(params[:department])
    @department.company = current_company
    
      if @department.save
        flash[:notice] = 'Отдел добавлен'
        redirect_to control_new_department_path
      else
        flash[:error] = @department.errors.full_messages.join("\n")
        render "new_department"
      end
  end

  def edit_department
    @department = Department.find(params[:id])
  end

  def update_department
    params.permit!
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department])
       flash[:notice] = 'Сохранено'
       redirect_to control_departments_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to control_edit_department_path(@department)
    end
  end

  def destroy_department
    @department = Department.find(params[:id])
    if @department.workers.count > 0
      flash[:error] = "Нельзя удалить непустой отдел"
      redirect_to control_departments_path()
    else
      @department.destroy
      flash[:notice] = 'Отдел удалён'
      redirect_to control_departments_path()
    end
  end

  private
  def admin_page 
    @admin_page = true
  end
  
end
