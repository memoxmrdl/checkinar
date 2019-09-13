# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  validates :attended_at, presence: true

  enum status: {
    pending: "pending",
    confirmed: "confirmed"
  }
end
