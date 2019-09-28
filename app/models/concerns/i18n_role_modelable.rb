# frozen_string_literal: true

module I18nRoleModelable
  extend ActiveSupport::Concern

  class_methods do
    def i18n_valid_roles
      @i18n_valid_roles ||= self.valid_roles.each_with_object({}) do |role, i18n_roles|
        i18n_roles[role] = I18n.t(role, scope: "role_model.models.#{name.underscore}.attributes.roles_mask")
      end
    end
  end

  def i18n_roles
    @i18n_roles ||= roles.each_with_object({}) do |role, i18n_roles|
      i18n_roles[role] = I18n.t(role, scope: "role_model.models.#{self.class.name.underscore}.attributes.roles_mask")
    end
  end
end
