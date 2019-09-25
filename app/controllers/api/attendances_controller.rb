# frozen_string_literal: true

module API
  class AttendancesController < ApplicationController
    before_action :authenticate_user!

    def create
      result = API::CreateAttendance.call(organization: current_organization, attributes: attendance_params)

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
