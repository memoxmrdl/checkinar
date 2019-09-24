# frozen_string_literal: true

class CreateParticipant
  include Interactor

  attr_reader :activity, :user, :participant

  def call
    context.response = { status: :unprocessable_entity }

    find_activity
    find_or_create_user
    initialize_participant
    create_participant
  end

  private
    def find_activity
      @activity = context.organization.activities.find(context.activity_id)
    rescue ActiveRecord::RecordNotFound
      context.response[:json] = { alert: I18n.t(:record_not_found, scope: :generic) }
      context.response[:status] = :forbidden
      context.fail!
    end

    def find_or_create_user
      @user = context.organization.users.find_by(email: context.attributes[:email])

      unless user
        @user = context.organization.users.create(
          email: context.attributes[:email],
          password: SecureRandom.hex(10),
          organization_id: context.organization_id,
          roles: [:normal]
        )

        if user.errors.present?
          context.response[:json] = user.errors
          context.response[:status] = :unprocessable_entity
          context.fail!
        end
      end
    end

    def initialize_participant
      @participant = Participant.new(
        activity_id: activity.id,
        user_id: user.id,
        roles: context.attributes[:roles_mask].to_a.reject(&:blank?)
      )
    end

    def send_email_notification
      InvitesMailer.with(participant: participant).invite_email.deliver_now
    end

    def create_participant
      if participant.save
        send_email_notification

        context.response[:json] = participant
        context.response[:status] = :created
      else
        context.response[:json] = participant.errors
        context.fail!
      end
    end
end
