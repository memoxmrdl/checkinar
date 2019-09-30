# frozen_string_literal: true

module AuthorizationTestHelper
  attr_reader :authorization_token

  def authenticate(user)
    @authorization_token = JsonWebToken.encode(user_id: user.uuid)
  end

  def headers(options = {})
    headers = { ACCEPT: "application/json" }
    headers["Authorization"] = "Token token=#{options[:authorization] || authorization_token}"
    headers
  end
end
