# frozen_string_literal: true

module API
  class AttendancesUsersController < ApplicationController
    before_action :authenticate_user!

    def index
      result = API::IndexAttendancesUsers.call(organization: current_organization, params: params)

      respond_to do |format|
        format.json { render result.response }
        format.json_api_v1 { render result.response }
      end
    end
  end
end
