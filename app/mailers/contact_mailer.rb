# coding: utf-8

class ContactMailer < ActionMailer::Base
  Settings.site(default: 'workplay.in')

  def welcome_email(worker)
    @worker = worker
    if Rails.env.production?
	    mail(
	        to: @worker.email, 
	        from: ActionMailer::Base.smtp_settings[:user_name],
	        subject: '[WORKPLAY.IN] Добро пожаловать на сайт'
	    )
	else
		mail(
	        to: @worker.email, 
	        from: "hello@workplay.in",
	        subject: '[WORKPLAY.IN] Добро пожаловать на сайт'
	    )
	end
  end

end