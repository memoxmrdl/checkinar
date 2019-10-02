# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.credentials.secret_key_base)[0])
  rescue
    nil
  end
end
