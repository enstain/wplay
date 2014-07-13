class QuestsController < ApplicationController
  def show
  	@quest = Quest.company(current_company).find(params[:id])
  end

  def index
	  case params[:for]
	    when  "department"
	      @quests = current_worker.department.quests.all
	    when "me"
	      @quests = current_worker.quests.all
	    else
	  	  @quests = Quest.company(current_company).for_all.all
	  	end
  end
end
