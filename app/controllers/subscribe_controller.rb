class SubscribeController < ApplicationController
  def new
  	@email = params[:user][:address]
  	@subscribe = Subscribe.new(email: @email)
  	if @subscribe.save
  	  flash.now[:notice] = "<div class='alert alert-success'>Ваша заявка сохранена, спасибо за участие</div>"
  	else
  	  flash.now[:notice] = "<div class='alert alert-error'>Произошла ошибка, свяжитесь с нами напрямую</div>"
  	end
  end
end
