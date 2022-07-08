require "json_web_token"

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def auth
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      render json: payload(@user), status: :ok
    else
      render json: { data: { errors: ["Email e/ou senha inválidos"] } }, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user.present?

    { data: JwtGenerator.call(user) }
  end
end
