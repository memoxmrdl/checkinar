class UserAuthenticatedSerializer < ApplicationSerializer
  attributes :id,
             :email

  attribute :authentication_token do |object|
    JsonWebToken.encode(user_id: object.id)
  end
end
