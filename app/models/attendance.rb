# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  validates :attended_at, :user_id, :activity_id, presence: true
  validate :user_belongs_to_activity?

  enum status: {
    pending: "pending",
    confirmed: "confirmed"
  }

  def user_belongs_to_activity?
    return unless user.present?

    user = User.find_by(id: user_id)
    return if user.activities.where(id: activity_id).exists?

    errors[:base] << I18n.t("activerecord.errors.models.attendance.invalid")
  end
end
