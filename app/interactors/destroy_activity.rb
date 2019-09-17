# frozen_string_literal: true

class DestroyActivity
  include Interactor

  def call
    destroy_activity
  end

  private
    def destroy_activity
      if context.destroy.delete
        context.status = :success
      else
        context.status = :unprocessable_entity
        context.fail!
      end
    end
end
