class QuestsController < ApplicationController

  before_action :quest_page

  def show
  	@quest = Quest.company(current_company).find(params[:id])
  end

  def index
	  case params[:for]
	    when  "department"
	      @quests = current_worker.department.quests.all
	    when "me"
	      @quests = current_worker.quests.all
	    when "all"
	  	  @quests = Quest.company(current_company).for_all.all
	  	else
	  	  @quests = current_worker.legale_quests
	  	end
  end

  def assigned
    @quests = current_worker.assigned_quests
    render action: "index"
  end

  def get
  	@quest = Quest.find(params[:id])
  	@assignment = Assignment.create(quest_id: @quest.id, worker_id: current_worker.id)
  	@assignment.save
  	redirect_to quests_path
  end

  private
  def quest_page 
    @quest_page = true
  end
end
