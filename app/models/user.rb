# frozen_string_literal: true

class User < ApplicationRecord
  include RoleModel
  include I18nRoleModelable

  has_many :attendances
  has_many :participants
  has_many :activities, through: :participants
  has_one_attached :avatar
  belongs_to :organization

  accepts_nested_attributes_for :organization, update_only: true

  validates :full_name, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  roles_attribute :roles_mask
  roles :owner, :normal
end
