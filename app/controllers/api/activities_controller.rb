# frozen_string_literal: true

module API
  class ActivitiesController < ApplicationController
    before_action :initialize_activity, only: %i[show edit update]

    def create
      result = API::CreateActivity.call(organization: current_organization, attributes: activity_params)
      render result.response
    end

    def index
      @activities = current_organization.activities
      render json: ::ActivitySerializer.new(@activities).serialized_json
    end

    def show
      render json: ::ActivitySerializer.new(@activity).serialized_json
    end

    def update
      result = API::UpdateActivity.call(activity: @activity, attributes: activity_params)
      render result.response
    end

    private
      def activity_params
        params.permit(
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
          occurs_frequency: [],
        )
      end

      def initialize_activity
        @activity = current_organization.activities.find(params[:id])
      end
  end
end
