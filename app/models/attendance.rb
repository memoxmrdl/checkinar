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


class Attendance < ApplicationRecord
  include I18nEnumrable

  belongs_to :activity
  belongs_to :user

  validates :attended_at, presence: true
  validate :activity_should_be_active_validation
  validate :user_belongs_to_activity_validation
  validate :attendance_in_accordance_to_activity_validation, on: :create

  enum status: {
    pending: "pending",
    confirmed: "confirmed"
  }

  i18n_enum_attribute :status

  scope :having_attended_at_between, -> (start_date, end_date) { where(attended_at: start_date.beginning_of_day..end_date.end_of_day) }

  private
    def user_belongs_to_activity_validation
      if user_id_changed? && activity_id_changed? && !activity.participants.exists?(user_id: user_id)
        errors.add(:user, :user_not_belongs_to_activity)
      end
    end

    def attendance_in_accordance_to_activity_validation
      if activity && activity.date? && activity.occurs_at != attended_at.to_date
        errors.add(:attended_at, :activity_occurs_at_different_than)
      elsif activity && activity.more_than_once? && activity.occurs_frequency.include?(attended_at.strftime("%A").downcase)
        errors.add(:attended_at, :activity_occurs_frequency_invalid)
      end
    end

    def activity_should_be_active_validation
      if activity && !activity.active?
        errors.add(:activity, :inactive)
      end
    end
end
