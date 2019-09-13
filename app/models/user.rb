# frozen_string_literal: true

class User < ApplicationRecord
  include RoleModel

  has_and_belongs_to_many :activities
  has_many :attendances
  belongs_to :organization

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  scope :owner, -> { where(roles_mask: User.mask_for(:owner)) }
  scope :leader, -> { where(roles_mask: User.mask_for(:leader)) }
  scope :attender, -> { where(roles_mask: User.mask_for(:attender)) }

  roles_attribute :roles_mask
  roles :owner, :leader, :attender
end
