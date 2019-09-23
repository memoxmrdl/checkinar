# frozen_string_literal: true

class ParticipantPolicy < ApplicationPolicy
  def create?
    user.is_owner? || record.activity.participants.exists?(user_id: user.id, roles_mask: Participant.mask_for(:leader))
  end

  alias_method :destroy?, :create?
end
