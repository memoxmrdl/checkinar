# frozen_string_literal: true

module API
  class ParticipantsController < ApplicationController
    before_action :authenticate_user!

    def show
      participant = current_organization.participants.find_by!(uuid: params[:id])

      respond_to do |format|
        format.json { render json: ParticipantSerializer.new(participant) }
        format.json_api_v1 { render json: ParticipantSerializer.new(participant) }
      end
    end
  end
end
