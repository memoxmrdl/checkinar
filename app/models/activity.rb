# frozen_string_literal: true

class Activity < ApplicationRecord
  include I18nEnumable

  has_many :participants
  has_many :users, through: :participants
  has_many :attendances
  belongs_to :organization

  validates :name, :occurs_on, presence: true
  validates :occurs_at,
            :start_at,
            :duration, presence: true, if: Proc.new { |a| a.occurs_on_changed? && a.date? }
  validates :occurs_frequency,
            :start_at,
            :duration, presence: true, if: Proc.new { |a| a.occurs_on_changed? && a.more_than_once? }

  i18n_enum_attribute :occurs_on

  enum occurs_on: {
    date: "date",
    more_than_once: "more_than_once"
  }
end
