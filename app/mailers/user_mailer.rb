class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bem-vindo(a) ao MAINORALHO!')
  end

  def recovery_password_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Recuperação de senha MAINORALHO' )
  end
end
