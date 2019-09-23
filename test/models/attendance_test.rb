# frozen_string_literal: true

require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  def setup
    @subject = Attendance.new
  end

  def test_it_creates_valid_if_user_belongs_to_activity
    @subject.activity = activities(:book_club)
    @subject.user = users(:attender)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert @subject.save
  end

  def test_it_does_not_creates_if_user_does_not_belongs_to_activity
    @subject.activity = activities(:book_club)
    @subject.user = users(:laura)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.save
  end

  def test_it_creates_invalid
    assert_not @subject.save
  end
end
