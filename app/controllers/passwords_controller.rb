class PasswordsController < ApplicationController
	skip_before_action :authenticate_user
  before_action :http_token, only: :reset

  def forgot
    render json: { error: 'Email não está presente' } and return if params[:email].blank?
  
    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!

      UserMailer.with(user: user).recovery_password_email.deliver_later

      render json: { auth_token: user.reset_password_token }, status: :ok
    else
      render json: {error: ['Endereço de email não encontrado. Por favor verifique e tente novamente.']}, status: :not_found
    end
  end

  def reset
    render json: { errors: 'Token não está presente' } and return if http_token.blank?
  
    user = User.find_by(reset_password_token: http_token)
  
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: 'resetou'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link inválido ou expirado. Tente gerar um novo link.']}, status: :not_found
    end
  end

  private

  def http_token
    @http_token ||= (request.headers["Authorization"].split(" ").last if request.headers["Authorization"].present?)
  end
end
