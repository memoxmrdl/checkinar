# frozen_string_literal: true

module API
  class ActivitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_activity, except: %i[index]

    def index
      activities = current_user.activities

      render json: ActivitySerializer.new(activities)
    end

    def show
      options = {}
      options[:include] = [:users]
      options[:params] = { start_date: params[:start_date], end_date: params[:end_date] }
      render json: ActivitySerializer.new(@activity, options)
    end

    private
      def find_activity
        @activity = current_user.activities.find(params[:id])
      end
  end
end
