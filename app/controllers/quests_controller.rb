class QuestsController < ApplicationController
  def show
  	@quest = Quest.find(params[:id])
  end
end
