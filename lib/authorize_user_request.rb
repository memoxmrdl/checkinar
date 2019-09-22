# frozen_string_literal: true

class AuthorizeUserRequest
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def self.call(token)
    new(token).user
  end

  def user
    @user ||= User.find_by(id: user_id) if user_id?
    @user || errors.add(:base, :token_invalid) && nil
  end

  private
    def decode_token
      @decode_token ||= JsonWebToken.decode(token)
    end

    def user_id
      decode_token.dig("user_id") || decode_token.dig(:user_id)
    end

    def user_id?
      user_id.present?
    end
end
