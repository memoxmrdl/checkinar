# frozen_string_literal: true

require "test_helper"

class InvitesMailerTest < ActionMailer::TestCase
  def setup
    @subject = InvitesMailer
  end

  def test_invite_email
    participant = participants(:leader)

    email = @subject.with(participant: participant).invite_email.deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [participant.user.email], email.to
  end
end
