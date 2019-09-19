# frozen_string_literal: true

module API
  class UpdateActivity < ::UpdateActivity
    private
      def update_activity
        if context.activity.update(context.attributes)
          context.response = ::ActivitySerializer.new(@activity).serialized_json
          context.status = :accepted
        else
          context.response = { error: I18n.t(".alert"), status: :unprocessable_entity }
          context.status = :unprocessable_entity
          context.fail!
        end
      end
  end
end
