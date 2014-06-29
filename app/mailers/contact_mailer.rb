# coding: utf-8

class ContactMailer < ActionMailer::Base
  Settings.site(default: 'wplay.ru')

  default from: "noreply@#{Settings.site}"

  def welcome_email(worker)
    @worker = worker
    mail(
        to: @worker.email, 
        subject: '[WPLAY] Добро пожаловать на сайт'
    )
  end

end