require "json_web_token"

class ApplicationController < ActionController::API
  before_action :authenticate_user

  rescue_from ActionController::ParameterMissing do |error|
    render json: { data: { errors: [error.message] } }, status: :bad_request
  end

  def authenticate_user
    if current_user.blank?
      render json: { data: { errors: ["Token inválido ou expirado"] } }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find(auth_token[:user_id])
  rescue JWT::DecodeError
    nil
  end

  private

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def http_token
    @http_token ||= (request.headers["Authorization"].split(" ").last if request.headers["Authorization"].present?)
  end
end
