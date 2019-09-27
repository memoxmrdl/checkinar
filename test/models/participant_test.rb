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

  def test_it_is_not_valid_without_role
    @subject.user = users(:laura)
    @subject.activity = activities(:book_club)

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_without_a_user_relation
    @subject.activity = activities(:book_club)
    @subject.roles << :attender

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_without_an_activity_relation
    @subject.user = users(:laura)
    @subject.roles << :attender

    assert_not @subject.valid?
  end

  def test_it_creates_participant_valid
    @subject.user = users(:laura)
    @subject.roles << :attender

    assert_not @subject.valid?
  end

  def test_it_is_not_valud_participant_when_activity_is_inactive
    activity = activities(:book_club)
    activity.toggle(:active)

    @subject.user = users(:laura)
    @subject.activity = activity
    @subject.roles << :attender

    assert_not @subject.save
  end
end
