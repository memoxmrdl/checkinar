# frozen_string_literal: true

require "test_helper"

class ConfirmAttendancesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @leader = users(:pedro)
    @attendance = attendances(:third)
    @activity = @attendance.activity
  end

  def test_it_confirms_an_attendance_of_attender
    sign_in @leader

    patch activity_confirm_attendance_path(@activity, @attendance)

    assert_equal flash[:notice], I18n.t("confirm_attendances.update.notice")
    assert_response :redirect
  end

  def test_it_wont_confirm_an_attendance_when_attendance_is_confirmed
    sign_in @leader

    @attendance.confirmed!

    patch activity_confirm_attendance_path(@activity, @attendance)

    assert_equal flash[:alert], I18n.t("generic.flash.record_not_found")
    assert_response :redirect
  end

  def test_it_wont_confirm_an_attendance_when_leader_doesnt_belongs_to_activity_try_confirmed
    sign_in users(:leader)

    patch activity_confirm_attendance_path(@activity, @attendance)

    assert_equal flash[:alert], I18n.t("pundit.no_authorized")
    assert_response :redirect
  end
end
