class BoardController < ApplicationController

  def index
  	@actions = Action.all.order_by(c_at: -1)
  end

end
