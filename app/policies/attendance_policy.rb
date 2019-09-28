# frozen_string_literal: true

class AttendancePolicy < ApplicationPolicy
  def update?
    user.is_owner? || record.activity.participants.exists?(user_id: user.id, roles_mask: Participant.mask_for(:leader))
  end
end
