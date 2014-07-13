# coding: utf-8

class ContactMailer < ActionMailer::Base
  Settings.site(default: 'workplay.in')


  default from: Rails.env.production? ? ActionMailer::Base.smtp_settings[:user_name] : "hello@workplay.in"

  def welcome_email(worker)
    @worker = worker
    mail(
        to: @worker.email, 
        subject: '[WORKPLAY.IN] Добро пожаловать на сайт'
    )
  end

  def welcome_company_email(admin)
  	@admin = admin
  	@company = @admin.company
	  mail(
        to: "#{@admin.email};support@workplay.in", 
        subject: '[WORKPLAY.IN] Добро пожаловать на сайт'
    )
  end

end