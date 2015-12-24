class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.new_post.subject
  #
  def new_post(ip, vessel)
  	@ip = ip
  	@vessel = vessel
    mail(to: "theodoretopol@gmail.com", subject: "Foo")
  end

  def edit_post(ip, new_vessel, vessel, params)
  	@ip = ip
  	@new_vessel = new_vessel
  	@vessel = vessel
  	@params = params
  	mail(to: "theodoretopol@gmail.com", subject: "Foo")
  end
end
