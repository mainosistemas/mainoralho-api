class PasswordsController < ApplicationController
	skip_before_action :authenticate_user

  def forgot
    if params[:email].blank?
      return render json: {error: 'Email não está presente'}
    end
  
    user = User.find_by(email: params[:email])
  
    if user.present?
      user.generate_password_token!

      UserMailer.with(user: user).recovery_password_email.deliver_later

      render json: {token: user.reset_password_token}, status: :ok
    else
      render json: {error: ['Endereço de email não encontrado. Por favor verifique e tente novamente.']}, status: :not_found
    end
  end

  def reset
    token = params[:token].to_s
  
    if params[:token].blank?
      return render json: {error: 'Token não está presente'}
    end
  
    user = User.find_by(reset_password_token: token)
  
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: 'resertou'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link inválido ou expirado. Tente gerar um novo link.']}, status: :not_found
    end
  end
end
