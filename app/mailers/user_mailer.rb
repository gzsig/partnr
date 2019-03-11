class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Partner')
  end

  def new_partnrs(user, good)
    @user = user
    @good = good
    mail(to: @user.email, subject: 'You have new Partnrs')
  end

  def contract_ready(user, good)
    @user = user
    @good = good
    mail(to: @user.email, subject: 'You have a new Contract to sign')
  end

end
