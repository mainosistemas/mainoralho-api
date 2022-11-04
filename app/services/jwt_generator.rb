class JwtGenerator
  def initialize(user)
    @user = user
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    generate
  end

  private

  attr_reader :user

  def generate
    {
      user: {
        auth_token: JsonWebToken.encode(
          { user_id: user.id, access_key: access_key }
        ),
        id: user.id,
        email: user.email,
        name: user.name
      }
    }
  end

  def access_key
    Digest::SHA256.hexdigest("#{user.created_at.to_i.to_s.reverse}#{user.created_at.to_i}")
  end
end
