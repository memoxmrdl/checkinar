# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  description         :string
#  occurs_on           :string
#  occurs_frequency    :string
#  occurs_at           :date
#  start_at            :time
#  duration            :integer
#  active              :boolean          default(TRUE)
#  latitude            :decimal(, )
#  longitude           :decimal(, )
#  radius              :decimal(, )
#  organization_id     :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  validate_attendance :boolean          default(FALSE), not null
#


class Activity < ApplicationRecord
  include I18nEnumrable

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

  enum occurs_on: {
    date: "date",
    more_than_once: "more_than_once"
  }

  i18n_enum_attribute :occurs_on

  def has_location?
    latitude && longitude
  end
end
