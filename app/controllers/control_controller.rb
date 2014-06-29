class ControlController < ApplicationController

  before_action :authenticate_admin!

  def index
  end

  def invite
  end
  
end
