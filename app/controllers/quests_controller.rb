class QuestsController < ApplicationController
  def show
  	@quest = Quest.company(current_company).find(params[:id])
  end
end
