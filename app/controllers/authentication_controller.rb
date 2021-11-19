require "json_web_token"

class AuthenticationController < ApplicationController
    def auth
      @user = User.find_by(email: params[:email])
      if @user&.authenticate(params[:password])
        render json: payload(@user), status: :ok
      else
        invalid_credentials
      end
    end

    private

    def payload(user)
      return nil unless user.present?

      {
        data: auth_token_json(user)
      }
    end

    def invalid_credentials
        render json: { data: { errors: "Email e/ou senha inválidos" } }, status: :unauthorized
    end

    def auth_token_json(user)
      { user: { auth_token: JsonWebToken.encode({ user_id: user.id, access_key: access_key(user) }), email: user.email, name: user.name } }
    end

    def access_key(user)
      Digest::SHA256.hexdigest("#{user.created_at.to_i.to_s.reverse}#{user.created_at.to_i}")
    end
  end
