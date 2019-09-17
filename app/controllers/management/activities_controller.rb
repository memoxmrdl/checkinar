# frozen_string_literal: true

module Management
  class ActivitiesController < BaseController
    before_action :find_activity, except: %i[index new create]
    before_action :authorize_activity

    def index
      @activities = current_organization.activities
    end

    def show; end

    def new
      @activity = Activity.new
    end

    def create
      result = ::CreateActivity.call(organization: current_organization, attributes: activity_params)

      @activity = result.activity

      if result.success?
        redirect_to management_activity_path(@activity), notice: t(".notice")
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
        redirect_to management_activity_path(@activity), notice: t(".notice")
      else
        flash.now[:alert] = t(".alert")

        render :edit, status: result.status
      end
    end

    def destroy
      result = ::DestroyActivity.call(activity: @activity)

      @activity = result.activity

      if result.success?
        redirect_to management_activities_path, notice: t(".notice")
      else
        redirect_to management_activity_path(@activity), alert: t(".alert")
      end
    end

    private
      def activity_params
        params.require(:activity).permit(
          :name,
          :description,
          :occurs_on,
          :occurs_frequency,
          :occurs_at,
          :start_at,
          :duration,
          :active,
          :latitude,
          :longitude,
          :radius
        )
      end

      def find_activity
        @activity = current_organization.activities.find(params[:id])
      end

      def authorize_activity
        authorize(@activity || Activity)
      end
  end
end
