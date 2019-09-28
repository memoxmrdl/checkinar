# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_participant, only: :index

  def create
    result = CreateParticipant.call(organization: current_organization, attributes: participant_params, activity_id: params[:activity_id])

    render result.response
  end

  def destroy
    activity = current_organization.activities.find(params[:activity_id])

    @participant = activity.participants.find(params[:id])

    authorize @participant

    if @participant.destroy
      redirect_to activity_path(activity), notice: t(".notice")
    else
      redirect_to activity_path(activity), alert: t(".alert")
    end
  end

  private
    def participant_params
      params.require(:participant).permit(
        :email,
        roles_mask: []
      )
    end

    def authorize_participant
      authorize(@participant || Participant)
    end
end
