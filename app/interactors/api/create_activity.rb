# frozen_string_literal: true

module API
  class CreateActivity < ::CreateActivity
    private
      def create_activity
        context.activity = Activity.new(context.attributes.merge(organization_id: context.organization.id))

        if context.activity.save
          context.response =  { json: ::ActivitySerializer.new(context.activity).serialized_json, status: :accepted }
        else
          context.response =  { json: { status:  :unprocessable_entity }, status: :unprocessable_entity }
          context.fail!
        end
      end
  end
end
