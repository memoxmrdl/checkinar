# frozen_string_literal: true

class User < ApplicationRecord
  include RoleModel

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  roles_attribute :roles_mask
  roles :owner, :leader, :attender
end
