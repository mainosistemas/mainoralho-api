require "json_web_token"

module LoginHelper
  def auth_token(user)
    {auth_token: JsonWebToken.encode({ user_id: user.id })}
  end
end
