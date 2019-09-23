# frozen_string_literal: true

require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  def setup
    @subject = Participant.new
  end

  def test_it_creates_participant_valid
    @subject.user = users(:laura)
    @subject.activity = activities(:book_club)
    @subject.roles << :attender

    assert @subject.save
  end

  def test_it_creates_participant_invalid
    assert_not @subject.save
  end
end
