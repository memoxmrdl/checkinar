# frozen_string_literal: true

module API
  class ActivitiesController < ApplicationController
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == "application/json" }
    before_action :initialize_activity, only: %i[show edit update]

    def create
      result = ::CreateActivity.call(organization: current_organization, attributes: activity_params)
      @activity = result.activity

      if result.success?
        render json: ::ActivitySerializer.new(@activity).serialized_json
      else
        render json: { error: t(".alert"), status: result.status }, status: result.status
      end
    end

    def edit
      render json: ::ActivitySerializer.new(@activity).serialized_json
    end

    def index
      @activities = current_organization.activities
      render json: ::ActivitySerializer.new(@activities).serialized_json
    end

    def show
      render json: ::ActivitySerializer.new(@activity).serialized_json
    end

    def update
      result = ::UpdateActivity.call(activity: @activity, attributes: activity_params)
      @activity = result.activity

      if result.success?
        render json: ::ActivitySerializer.new(@activity).serialized_json
      else
        render json: { error: t(".alert"), status: result.status }, status: result.status
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
          occurs_frequency: [],
        )
      end

      def initialize_activity
        @activity = current_organization.activities.find(params[:id])
      end
  end
end
