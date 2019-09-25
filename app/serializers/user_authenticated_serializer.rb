# frozen_string_literal: true

class UserAuthenticatedSerializer < ApplicationSerializer
  attributes :email

  attribute :id do |object|
    object.uuid
  end

  attribute :authentication_token do |object|
    JsonWebToken.encode(user_id: object.uuid)
  end
end
