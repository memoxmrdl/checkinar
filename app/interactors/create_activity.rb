# frozen_string_literal: true

class CreateActivity
  include Interactor

  def call
    create_activity
  end

  private
    def create_activity
      context.activity = Activity.new(context.attributes.merge(organization_id: context.organization.id))

      if context.activity.save
        context.status = :created
      else
        context.status = :unprocessable_entity
        context.fail!
      end
    end
end
