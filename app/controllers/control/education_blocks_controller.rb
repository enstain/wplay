class Control::EducationBlocksController < ControlController

  before_action :education_page

  def index
    @blocks = EducationBlock.company(current_company)
  end

  def new
    @block = EducationBlock.new
  end

  def create
    params.permit!
    @block = EducationBlock.create(params[:education_block])
    @block.company = current_company
    
      if @block.save
        flash[:notice] = 'Блок добавлен'
        redirect_to new_control_education_block_path
      else
        flash[:error] = @block.errors.full_messages.join("\n")
        render "new"
      end
  end

  def edit
    @block = EducationBlock.find(params[:id])
  end

  def update
    params.permit!
    @block = EducationBlock.find(params[:id])
    if @block.update_attributes(params[:education_block])
       flash[:notice] = 'Сохранено'
       redirect_to control_education_blocks_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to edit_control_education_block_path(@block)
    end
  end

  def destroy
    @block = EducationBlock.find(params[:id])
    @block.destroy
    flash[:notice] = 'Блок удалён'
    redirect_to control_education_blocks_path()
  end

  private
  def education_page 
    @education_page = true
  end

end