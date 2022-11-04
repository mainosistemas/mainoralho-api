class UsersController < ApplicationController
  before_action :set_user, only: %i[update]

  def update
    if @user.update(user_params)
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :tipo)
  end
end
