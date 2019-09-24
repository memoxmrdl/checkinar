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

  validates :full_name, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  scope :top_ten_participants, ->(activity_id, star_date, end_date) {
    joins(:activities)
    .joins(:attendances)
    .group("users.id")
    .order("count(attendances.user_id) desc")
    .where("attendances.activity_id = #{activity_id}")
    .where("attendances.attended_at BETWEEN '#{star_date}' AND '#{end_date}'")
    .limit(10)
  }

  roles_attribute :roles_mask
  roles :owner, :normal
end
