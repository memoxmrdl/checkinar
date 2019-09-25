# frozen_string_literal: true

module API
  class CreateAttendance
    include Interactor

    attr_accessor :activity, :user, :attendance

    def call
      context.response = { status: :unprocessable_entity }

      find_activity
      find_user
      initialize_attendance
      user_location_is_inside_at_activity_location
      create_attendance
    end

    private
      def find_activity
        @activity = context.organization.activities.find_by!(uuid: context.attributes[:activity_id])
      rescue ActiveRecord::RecordNotFound
        context.response[:json] =  ErrorSerializer.new(:record_not_found, is_collection: false)
        context.response[:status] = :not_found
        context.fail!
      end

      def find_user
        @user = activity.users.find_by!(uuid: context.attributes[:user_id])
      rescue ActiveRecord::RecordNotFound
        context.response[:json] =  ErrorSerializer.new(:record_not_found, is_collection: false)
        context.response[:status] = :not_found
        context.fail!
      end

      def initialize_attendance
        @attendance = Attendance.new(
          context.attributes.slice(:latitude, :longitude).merge(
            activity_id: activity.id,
            user_id: user.id,
            attended_at: Time.zone.now,
            status: activity.validate_attendance? ? Attendance.statuses[:pending] : Attendance.statuses[:confirmed]
          )
        )
      end

      def user_location_is_inside_at_activity_location
        if activity.has_location?
          user_location = { latitude: context.attributes[:latitude].to_f, longitude: context.attributes[:longitude].to_f }
          activity_location = { latitude: activity.latitude, longitude: activity.longitude }

          result = PointInsideRadius.new(user_location, activity_location, activity.radius).is_inside?

          unless result
            attendance.errors.add(:base, :user_is_not_at_activity_location)
            context.response[:json] = ErrorSerializer.new(attendance)
            context.response[:status] = :unprocessable_entity
            context.fail!
          end
        end
      end

      def create_attendance
        if attendance.save
          context.response[:json] = AttendanceSerializer.new(attendance)
          context.response[:status] = :created
        else
          context.response[:json] =  ErrorSerializer.new(attendance)
          context.response[:status] = :unprocessable_entity
          context.fail!
        end
      end
  end
end
