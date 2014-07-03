# coding: utf-8

class ContactMailer < ActionMailer::Base
  Settings.site(default: 'workplay.in')

  def welcome_email(worker)
    @worker = worker
    mail(
        to: @worker.email, 
        from: ActionMailer::Base.smtp_settings[:user_name],
        subject: '[WORKPLAY.IN] Добро пожаловать на сайт'
    )
  end

end