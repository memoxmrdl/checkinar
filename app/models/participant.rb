# frozen_string_literal: true

class Participant < ApplicationRecord
  include RoleModel

  belongs_to :user
  belongs_to :activity

  roles_attribute :roles_mask

  roles :leader, :attender
end
