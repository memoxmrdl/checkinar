# frozen_string_literal: true

class UserAuthenticatedSerializer < ApplicationSerializer
  attributes :email

  attribute :id do |object|
    object.uuid
  end

  attribute :avatar_url do |object|
    if object.avatar.attached?
      Rails.application.routes.url_helpers.url_for(object.avatar.variant(resize_to_limit: [128, 128]))
    else
      ""
    end
  end

  attribute :authentication_token do |object|
    JsonWebToken.encode(user_id: object.uuid)
  end
end
