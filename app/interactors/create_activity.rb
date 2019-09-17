# frozen_string_literal: true

class CreateActivity
  include Interactor

  def call
    create_activity
  end

  private
    def create_activity
      context.activity = context.organization.activities.create(context.attributes)

      if context.activity.persisted?
        context.status = :created
      else
        context.status = :unprocessable_entity
        context.fail!
      end
    end
end
