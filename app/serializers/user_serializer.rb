# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  roles_mask             :integer
#  organization_id        :bigint
#  full_name              :string
#


class UserSerializer < ApplicationSerializer
  set_id :uuid

  attributes :email, :full_name

  attribute :avatar_url do |object|
    if object.avatar.attached?
      Rails.application.routes.url_helpers.url_for(object.avatar.variant(resize_to_limit: [128, 128]))
    else
      ""
    end
  end
end
