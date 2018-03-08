class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def welcome_email(user)
    @user = user
    @url = 'localhost:3000/session/new'
    mail(to: @user, subject: 'Thanks for signing up!')
  end
end
