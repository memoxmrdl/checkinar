# frozen_string_literal: true

# froze_string_literal: true

module API
  class AttendancesController < ApplicationController
    def create
      result = API::CreateAttendance.call(attributes: attendance_params)
      render result.response
    end

    private
      def attendance_params
        params.permit(
          :user_id,
          :activity_id,
          :latitude,
          :longitude,
        )
      end
  end
end
