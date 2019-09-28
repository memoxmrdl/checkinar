# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    true
  end

  alias_method :update?, :edit?

  def permitted_attributes
    if user.owner?
      [
        :avatar, :full_name,
        organization_attributes: [ :name ]
      ]
    else
      [:avatar, :full_name]
    end
  end
end
