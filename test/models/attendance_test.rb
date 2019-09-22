# frozen_string_literal: true

require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  def setup
    @subject = Attendance.new
  end

  def test_it_creates_valid
    @subject.activity = activities(:book_club)
    @subject.user = users(:attender)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.save
  end

  def test_it_creates_invalid
    assert_not @subject.save
  end


  def test_it_creates_valid_if_user_belongs_to_activity
    user = users(:attender)
    user.activities << activities(:book_club)
    user.save
    @subject.activity = activities(:book_club)
    @subject.user = user
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert @subject.save
  end
end
