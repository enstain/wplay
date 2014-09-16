class Control::QuestsController < ControlController

  before_action :quest_page

  def index
    @quests = Quest.company(current_company)
  end

  def new
    @quest = Quest.new
  end

  def create
    params.permit!
    @quest = Quest.create(params[:quest])
    @quest.company = current_company
    
      if @quest.save
        flash[:notice] = 'Квест добавлен'
        Action.create(action_object: @quest, type: :new_quest, company: current_company, tie: ApplicationController.helpers.quest_for(@quest))
        redirect_to new_control_quest_path
      else
        flash[:error] = @quest.errors.full_messages.join("\n")
        render "new"
      end
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    params.permit!
    @quest = Quest.find(params[:id])
    if @quest.update_attributes(params[:quest])
       flash[:notice] = 'Сохранено'
       Action.create(action_object: @quest, type: :update_quest, company: current_company, tie: ApplicationController.helpers.quest_for(@quest))
       redirect_to control_quests_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to edit_control_quest_path(@quest)
    end
  end

  def destroy
    @quest = Quest.find(params[:id])
    @quest.destroy
    flash[:notice] = 'Квест удалён'
    redirect_to control_quests_path()
  end

  private
  def quest_page 
    @quest_page = true
  end

end