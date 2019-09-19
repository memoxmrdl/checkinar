# frozen_string_literal: true

module API
  class UpdateActivity < ::UpdateActivity
    private
      def update_activity
        if context.activity.update(context.attributes)
          context.response = { json: ::ActivitySerializer.new(@activity).serialized_json, status: :accepted }
        else
          context.response = { json: { status: :unprocessable_entity }, status: :unprocessable_entity }
          context.fail!
        end
      end
  end
end
