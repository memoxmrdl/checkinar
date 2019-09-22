# frozen_string_literal: true

module API
  class CreateAttendance
    include Interactor

    def call
      validate_if_user_is_in_activity_range
      create_attendance
    end

    private
      def attendance_params
        {
          activity_id: context.attributes[:activity_id],
          user_id: context.attributes[:user_id],
          attended_at: Time.now,
          status: @activity.validate_attendance ? "pending" : "confirmed"
        }
      end

      def create_attendance
        context.attendance = Attendance.new(attendance_params)
        if context.attendance.save
          context.response =  { json: { status:  :accept }, status: :accept }
        else
          context.response =  { json: { status:  :unprocessable_entity }, status: :unprocessable_entity }
          context.fail!
        end
      end

      def validate_if_user_is_in_activity_range
        @activity = Activity.find(context.attributes[:activity_id])
        return unless @activity.latitude && @activity.longitude

        activity_location = "#{@activity.latitude},#{@activity.longitude}"
        user_location = "#{context.attributes[:latitude]},#{context.attributes[:longitude]}"
        distance = Distance.meassure(activity_location, user_location)
        return if distance < @activity.radius

        context.response =  { json: { status:  :unprocessable_entity }, status: :unprocessable_entity }
        context.fail!
      end
  end
end
