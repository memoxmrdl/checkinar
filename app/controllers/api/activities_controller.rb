# frozen_string_literal: true

module API
  class ActivitiesController < ApplicationController
    before_action :authenticate_user!

    include Concerns::Serializable

    def index
      respond_to do |format|
        format.json { render json: @serialized_collection }
        format.json_api_v1 { render json: @serialized_collection }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @serialized_resource }
        format.json_api_v1 { render json: @serialized_resource }
      end
    end
  end
end
