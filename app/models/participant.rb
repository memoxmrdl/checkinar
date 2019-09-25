# frozen_string_literal: true

# == Schema Information
#
# Table name: participants
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  activity_id :bigint
#  roles_mask  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class Participant < ApplicationRecord
  include RoleModel
  include I18nRoleModelable

  belongs_to :user
  belongs_to :activity

  validate :roles_mask_validation
  validate :user_belongs_to_activity_validation

  roles_attribute :roles_mask

  roles :leader, :attender

  delegate :email, to: :user

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
