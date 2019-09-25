# frozen_string_literal: true

module API
  class ActivitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_activity, except: %i[index]

    def index
      activities = current_user.activities

      result_response = ActivitySerializer.new(activities)

      respond_to do |format|
        format.json { render json: result_response }
        format.json_api_v1 { render json: result_response }
      end
    end

    def show
      result_response = ActivitySerializer.new(@activity, params: { include: params[:include] })

      respond_to do |format|
        format.json { render json: result_response }
        format.json_api_v1 { render json: result_response }
      end
    end

    private
      def find_activity
        @activity = current_user.activities.find_by!(uuid: params[:id])
      end
  end
end
