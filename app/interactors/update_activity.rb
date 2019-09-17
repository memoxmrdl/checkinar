# frozen_string_literal: true

class UpdateActivity
  include Interactor

  def call
    update_activity
  end

  private
    def update_activity
      if context.activity.update(context.attributes)
        context.status = :accepted
      else
        context.status = :unprocessable_entity
        context.fail!
      end
    end
end
