class Control::DepartmentsController < ControlController

  def index
    @department_page = true
    @departments = Department.company(current_company).all
  end

  def new
  	@department_page = true
    @department = Department.new
  end

  def create
    params.permit!
    @department = Department.create(params[:department])
    @department.company = current_company
    
      if @department.save
        flash[:notice] = 'Отдел добавлен'
        redirect_to new_control_department_path
      else
        flash[:error] = @department.errors.full_messages.join("\n")
        render "new"
      end
  end

  def edit
  	@department_page = true
    @department = Department.find(params[:id])
  end

  def update
    params.permit!
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department])
       flash[:notice] = 'Сохранено'
       redirect_to control_departments_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to edit_control_department_path(@department)
    end
  end

  def destroy
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
end