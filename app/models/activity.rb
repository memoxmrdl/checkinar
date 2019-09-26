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

  def location
    [latitude.to_f, longitude.to_f]
  end

  def has_location?
    !(latitude.to_f.zero? || longitude.to_f.zero?)
  end

  def self.i18n_occurs_frequency_options(locale: I18n.default_locale)
    I18n.t("date.day_names", locale: :en).each_with_object({}).with_index do |(day_name, day_names), index|
      day_names[day_name.downcase] = I18n.t("date.day_names", locale: locale)[index]
    end
  end

  def i18n_occurs_frequency
    occurs_frequency.to_a.reject(&:blank?).each_with_object([]) do |day_name, day_names|
      day_names << Activity.i18n_occurs_frequency_options[day_name.downcase]
    end
  end
end
