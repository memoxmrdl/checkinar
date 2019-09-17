# frozen_string_literal: true

class Activity < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :organization

  validates :name, presence: true

  enum occurs_on: {
    monday: "monday",
    tuesday: "tuesday",
    wednesday: "wednesday",
    thursday: "thursday",
    friday: "friday",
    saturday: "saturday",
    sunday: "sunday",
    every_day: "every_day",
    none_on: "none_on"
  }

  enum occurs_frequency: {
    daily: "daily",
    weekly: "weekly",
    montly: "monthly"
  }
end
