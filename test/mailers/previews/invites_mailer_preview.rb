# Preview all emails at http://localhost:3000/rails/mailers/invites_mailer
class InvitesMailerPreview < ActionMailer::Preview
  def invite_email
    participant = Participant.all.sample

    InvitesMailer.with(participant: participant).invite_email
  end
end
