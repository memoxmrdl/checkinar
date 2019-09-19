# frozen_string_literal: true

module API
  class CreateActivity < ::CreateActivity
    private
      def create_activity
        context.activity = Activity.new(context.attributes.merge(organization_id: context.organization.id))

        if context.activity.save
          context.response = ::ActivitySerializer.new(context.activity).serialized_json
          context.status = :accepted
        else
          context.response =  { error: I18n.t(".alert"), status:  :unprocessable_entity }
          context.status = :unprocessable_entity
          context.fail!
        end
      end
  end
end
