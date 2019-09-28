# frozen_string_literal: true

class InvitesMailer < ApplicationMailer
  def invite_email
    @participant = params[:participant]
    @user = @participant.user
    @activity = @participant.activity

    mail(to: @user.email, subject: "Has sido invitado a participat en #{@activity.name} desde Checkinar!")
  end
end
