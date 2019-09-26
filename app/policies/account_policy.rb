# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def edit?
    true
  end

  alias_method :update?, :edit?

  def permitted_attributes
    if user.owner?
      [
        :full_name,
        organization_attributes: [
          :id, :name
        ]
      ]
    else
      [:full_name]
    end
  end
end
