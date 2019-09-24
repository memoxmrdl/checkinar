# frozen_string_literal: true

class User < ApplicationRecord
  include RoleModel

  has_many :attendances
  has_many :participants
  has_many :activities, through: :participants
  belongs_to :organization

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
