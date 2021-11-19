class RegistrationsController < ApplicationController
  def create
    if (user = User.create(user_params))
      render json: { data: {  } }, status: :created
    else
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :name)
  end
end
