# frozen_string_literal: true

class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user.is_owner?
  end

  def edit?
    user.is_owner? || record.participants.exists?(user: user, roles_mask: Participant.mask_for(:leader))
  end

  alias_method :show?, :index?
  alias_method :create?, :new?
  alias_method :update?, :edit?
  alias_method :destroy?, :new?

  class Scope < Scope
    def resolve
      if user.is_owner?
        scope.all
      elsif user.is_normal?
        user.activities
      end
    end
  end
end
