# frozen_string_literal: true

class Participant < ApplicationRecord
  include RoleModel

  belongs_to :user
  belongs_to :activity

  validate :roles_mask_validation
  validate :user_belongs_to_activity_validation

  roles_attribute :roles_mask

  roles :leader, :attender

  delegate :email, to: :user

  def self.i18n_valid_roles
    @i18n_valid_roles ||= self.valid_roles.each_with_object({}) do |role, i18n_roles|
      i18n_roles[role] = I18n.t(role, scope: "role_model.models.#{name.underscore}.attributes.roles_mask")
    end
  end

  def i18n_roles
    @i18n_roles ||= roles.each_with_object({}) do |role, i18n_roles|
      i18n_roles[role] = I18n.t(role, scope: "role_model.models.#{self.class.name.underscore}.attributes.roles_mask")
    end
  end

  private

    def roles_mask_validation
      if !has_any_role?(Participant.valid_roles)
        errors.add(:roles_mask, :choose_one)
      end
    end

    def user_belongs_to_activity_validation
      if user_id_changed? && activity.users.exists?(id: user)
        errors.add(:email, :user_belongs_to_activity)
      end
    end
end
