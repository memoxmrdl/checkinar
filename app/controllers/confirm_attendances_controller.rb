# frozen_string_literal: true

class ConfirmAttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_activity, :find_attendance, :authorize_attendance

  def update
    if @attendance.confirmed!
      redirect_to activity_path(@activity), notice: t(".notice")
    else
      redirect_to activity_path(@activity), alert: t(".alert")
    end
  end

  private
    def authorize_attendance
      authorize @attendance || Attendance
    end

    def find_activity
      @activity = current_organization.activities.find(params[:activity_id])
    end

    def find_attendance
      @attendance = @activity.attendances.pending.find(params[:id])
    end
end
