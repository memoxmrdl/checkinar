# frozen_string_literal: true

class Attendance < ApplicationRecord
  include I18nEnumrable

  belongs_to :activity
  belongs_to :user

  validates :attended_at, :user_id, :activity_id, presence: true
  validate :user_belongs_to_activity_validation

  enum status: {
    pending: "pending",
    confirmed: "confirmed"
  }

  i18n_enum_attribute :status

  scope :having_attended_at_between, -> (start_date, end_date) { where(attended_at: start_date.beginning_of_day..end_date.end_of_day) }

  def user_belongs_to_activity_validation
    if user_id_changed? && activity_id_changed? && !activity.participants.exists?(user_id: user_id)
      errors.add(:user, :user_not_belongs_to_activity)
    end
  end
end
