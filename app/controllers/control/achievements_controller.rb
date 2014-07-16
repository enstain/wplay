class Control::AchievementsController < ControlController

  def index
    @achieve_page = true
    @achieves = Achievement.company(current_company)
  end

  def new
    @achieve_page = true
    @achieve = Achievement.new
  end

  def create
    params.permit!
    @achieve = Achievement.create(params[:achievement])
    @achieve.company = current_company
    
      if @achieve.save
        flash[:notice] = 'Бейдж добавлен'
        redirect_to new_control_achievement_path
      else
        flash[:error] = @achieve.errors.full_messages.join("\n")
        render "new"
      end
  end

  def edit
    @achieve_page = true
    @achieve = Achievement.find(params[:id])
  end

  def update
    params.permit!
    @achieve = Achievement.find(params[:id])
    if @achieve.update_attributes(params[:achievement])
       flash[:notice] = 'Сохранено'
       redirect_to control_achievements_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to edit_control_achievement_path(@achieve)
    end
  end

  def destroy
    @achieve = Achievement.find(params[:id])
    @achieve.destroy
    flash[:notice] = 'Бейдж удалён'
    redirect_to control_achievements_path()
  end

end