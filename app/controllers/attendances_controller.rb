# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = SearchAttendances.call(
      scope: current_user.attendances,
      attributes: search_attendance_params,
    ).attendances.page(params[:attendances_page])
  end

  private
    def search_attendance_params
      params.fetch(:attendance, {}).permit(
        :date_range
      )
    end
end
