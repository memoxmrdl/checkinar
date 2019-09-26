# frozen_string_literal: true

module API
  class ParticipantsController < ApplicationController
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

    private
      def collection_conditions
        if params[:activiy_id]
          params.to_unsafe_h.slice(:activity_id)
        else
          {}
        end
      end
  end
end
