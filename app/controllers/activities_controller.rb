# frozen_string_literal: true

class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_activity, except: %i[index new create]
  before_action :authorize_activity

  def index
    @activities = policy_scope(Activity).page(params[:page])
  end

  def show
    @participants = @activity.participants.page(params[:participants_page])
    @attendances = SearchAttendances.call(activity: @activity, attributes: search_attendance_params).attendances.page(params[:attendances_page])
  end

  def new
    @activity = Activity.new
  end

  def create
    result = ::CreateActivity.call(organization: current_organization, attributes: activity_params)

    @activity = result.activity

    if result.success?
      redirect_to activity_path(@activity), notice: t(".notice")
    else
      flash.now[:alert] = t(".alert")

      render :new, status: result.status
    end
  end

  def edit; end

  def update
    result = ::UpdateActivity.call(activity: @activity, attributes: activity_params)

    @activity = result.activity

    if result.success?
      redirect_to activity_path(@activity), notice: t(".notice")
    else
      flash.now[:alert] = t(".alert")

      render :edit, status: result.status
    end
  end

  def destroy
    result = ::DestroyActivity.call(activity: @activity)

    @activity = result.activity

    if result.success?
      redirect_to activities_path, notice: t(".notice")
    else
      redirect_to activity_path(@activity), alert: t(".alert")
    end
  end

  private
    def activity_params
      params.require(:activity).permit(
        :name,
        :description,
        :occurs_on,
        :occurs_at,
        :start_at,
        :duration,
        :active,
        :latitude,
        :longitude,
        :radius,
        :validate_attendance,
        occurs_frequency: [],
      )
    end

    def search_attendance_params
      params.fetch(:attendance, {}).permit(
        :date_range
      )
    end

    def find_activity
      @activity = current_organization.activities.find(params[:id])
    end

    def authorize_activity
      authorize(@activity || Activity)
    end
end
