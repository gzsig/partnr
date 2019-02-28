class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Partner')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_partnrs.subject
  #
  def new_partnrs(user, good)
    @user = user
    @good = good
    mail(to: @user.email, subject: 'You have new Partnrs')
  end
end
