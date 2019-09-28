# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  roles_mask             :integer
#  organization_id        :bigint
#  full_name              :string
#


class User < ApplicationRecord
  include RoleModel
  include I18nRoleModelable

  has_many :attendances
  has_many :participants
  has_many :activities, through: :participants
  has_one_attached :avatar
  belongs_to :organization

  accepts_nested_attributes_for :organization, update_only: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, if: Proc.new { |user| user.full_name_changed?  }
  validates :avatar, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"], size_range: 0..5.megabytes }

  scope :by_attendances, ->(activity_id, order_by: :desc, start_date: Time.zone.now, end_date: Time.zone.now, limit: 10) {
    joins(:activities, :attendances)
    .group("users.id")
    .order(Arel.sql("count(attendances.user_id) #{order_by}"))
    .where(attendances: {
      activity_id: activity_id,
      status: Attendance.statuses[:confirmed],
      attended_at: start_date.beginning_of_day..end_date.end_of_day
    })
    .limit(limit)
  }

  roles_attribute :roles_mask
  roles :owner, :normal

  def full_name_or_email
    full_name || email
  end
end
