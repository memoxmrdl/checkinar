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
      render json: ActivitySerializer.new(@activity)
    end

    private
      def find_activity
        @activity = current_user.activities.find(params[:id])
      end
  end
end
