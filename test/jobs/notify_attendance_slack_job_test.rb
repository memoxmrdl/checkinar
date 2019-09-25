# frozen_string_literal: true

require "test_helper"

class NotifyAttendanceSlackJobTest < ActiveJob::TestCase
  def setup
    @subject = NotifyAttendanceSlackJob.new
    @attendance = attendances(:one)
    @user = @attendance.user
    @organization = organizations(:michelada)
  end

  def test_it_notifies_an_attendance
    expected_message = I18n.t(:user_attended_to_activity, scope: "slack.messages", user_name: @user.full_name)

    Slack::Notifier.any_instance.stubs(:ping).returns(expected_message)

    assert_performed_jobs 1 do
      NotifyAttendanceSlackJob.perform_later(@attendance.id)

      assert_equal @subject.perform(@attendance.id), expected_message
    end
  end
end
