# frozen_string_literal: true

module API
  class AttendancesController < ApplicationController
    before_action :authenticate_user!

    def create
      result = API::CreateAttendance.call(organization: current_organization, attributes: attendance_params)

      respond_to do |format|
        format.json { render result.response }
        format.json_api_v1 { render result.response }
      end
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
