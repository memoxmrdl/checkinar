# frozen_string_literal: true

class ParticipantSerializer < ApplicationSerializer
  set_id :uuid

  attributes :email

  attribute :roles do |object|
    object.user.i18n_roles.values.to_sentence
  end
end
