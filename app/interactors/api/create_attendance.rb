# frozen_string_literal: true

module API
  class CreateAttendance
    include Interactor

    def call
      context.response = { status: :unauthorized }

      find_activity
      user_is_neart_to_location
      create_attendance
    end

    private
      attr_accessor :attendance

      def find_activity
        @activity = Activity.find(context.attributes[:activity_id])
        return if @activity

        response_with_error
      end

      def create_attendance
        @attendance = Attendance.new(context.attributes.merge(attended_at: Time.zone.now,
                                                              status: (@activity.validate_attendance? ? Attendance.statuses[:pending] : Attendance.statuses[:confirmed])))
        if attendance.save
          context.response =  { json: { status:  :accepted }, status: :accepted }
        else
          response_with_error
        end
      end

      def user_is_neart_to_location
        return unless @activity.latitude && @activity.longitude

        latitude = context.attributes.delete(:latitude)
        longitude = context.attributes.delete(:longitude)
        activity_location = "#{@activity.latitude},#{@activity.longitude}"
        user_location = "#{latitude},#{longitude}"
        distance = Distance.meassure(activity_location, user_location)
        return if distance < @activity.radius

        response_with_error
      end

      def response_with_error
        context.response[:json] =  ErrorSerializer.new(attendance)
        context.response[:status] = :unprocessable_entity
        context.fail!
      end
  end
end
