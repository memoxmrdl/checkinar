# frozen_string_literal: true

# == Schema Information
#
# Table name: attendances
#
#  id          :bigint           not null, primary key
#  activity_id :bigint
#  user_id     :bigint
#  attended_at :datetime         not null
#  status      :string           default("pending"), not null
#  latitude    :decimal(, )
#  longitude   :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


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

  def test_it_is_not_valid_when_activity_is_inactive
    activity = activities(:book_club)
    activity.toggle(:active)

    @subject.activity = activity
    @subject.user = users(:attender)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.save
  end

  def test_it_does_not_creates_if_user_does_not_belongs_to_activity
    @subject.activity = activities(:book_club)
    @subject.user = users(:laura)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_without_attendded_at_attribute
    @subject.activity = activities(:book_club)
    @subject.user = users(:attender)
    @subject.attended_at = Date.parse("2019-09-10")
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_without_an_activity_relation
    @subject.user = users(:laura)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_without_an_user_relation
    @subject.activity = activities(:book_club)
    @subject.attended_at = Time.zone.now
    @subject.status = Attendance.statuses[:confirmed]

    assert_not @subject.valid?
  end
end
