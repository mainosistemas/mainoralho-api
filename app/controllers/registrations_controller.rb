require "json_web_token"

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user = User.new(user_params)
    if user.save
      render json: { data: { user: user.as_json } }, status: :created
    else
      render json: { data: { errors: user.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :name)
  end
end
