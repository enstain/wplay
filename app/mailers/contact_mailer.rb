# coding: utf-8

class ContactMailer < ActionMailer::Base
  Settings.site(default: 'workplay.in')

  default from: "noreply@#{Settings.site}"

  def welcome_email(worker)
    @worker = worker
    mail(
        to: @worker.email, 
        subject: '[WORKPLAY.IN] Добро пожаловать на сайт'
    )
  end

end