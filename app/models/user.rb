# frozen_string_literal: true

class User < ApplicationRecord
  include RoleModel

  has_many :attendances
  has_many :participants
  has_many :activities, through: :participants
  belongs_to :organization

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  roles_attribute :roles_mask
  roles :owner, :normal
end
