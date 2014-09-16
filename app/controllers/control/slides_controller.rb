class Control::SlidesController < ControlController

  before_action :education_page

  def index
    @block = EducationBlock.find(params[:id])
    @slides = Slide.where(education_block: @block).all
  end

  def new
    @slide = Slide.new
  end

  def create
    params.permit!
    @block = EducationBlock.find(params[:id])
    @slide = Slide.create(params[:slide])
    @slide.company = current_company
    @slide.education_block = @block
    
      if @slide.save
        flash[:notice] = 'Блок добавлен'
        redirect_to new_control_slide_path
      else
        flash[:error] = @slide.errors.full_messages.join("\n")
        render "new"
      end
  end

  def edit
    @slide = Slide.find(params[:id])
  end

  def update
    params.permit!
    @slide = Slide.find(params[:id])
    if @slide.update_attributes(params[:slide])
       flash[:notice] = 'Сохранено'
       redirect_to control_slides_path()
    else
       flash[:error] = 'Ошибка'
       redirect_to edit_control_slide_path(@slide)
    end
  end

  def destroy
    @slide = Slide.find(params[:id])
    @slide.destroy
    flash[:notice] = 'Блок удалён'
    redirect_to control_slides_path()
  end

  private
  def education_page 
    @education_page = true
  end

end