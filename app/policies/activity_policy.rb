# frozen_string_literal: true

class ActivityPolicy < ApplicationPolicy
  def index?
    user.is_owner? || user.is_leader?
  end

  def new?
    user.is_owner?
  end

  alias_method :create?, :new?
  alias_method :show?, :index?
  alias_method :edit?, :index?
  alias_method :update?, :index?
  alias_method :destroy?, :new?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
