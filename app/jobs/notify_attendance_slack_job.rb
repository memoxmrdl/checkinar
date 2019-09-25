# frozen_string_literal: true

class NotifyAttendanceSlackJob < ApplicationJob
  queue_as :default

  def perform(attendance_id)
    attendance = Attendance.find_by(id: attendance_id)
    return unless attendance

    activity = attendance.activity
    return unless activity.slack_channel

    user = attendance.user
    organization = activity.organization

    notifier = Slack::Notifier.new(organization.slack_webhook_url, channel: activity.slack_channel)
    notifier.ping(
      I18n.t(:user_attended_to_activity,
             scope: "slack.messages",
             user_name: user.full_name)
    )
  end
end
