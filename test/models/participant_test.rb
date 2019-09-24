# frozen_string_literal: true

# == Schema Information
#
# Table name: participants
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  activity_id :bigint
#  roles_mask  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


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
