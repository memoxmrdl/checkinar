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


class ActivitySerializer < ApplicationSerializer
  set_id :uuid

  attributes :name,
             :description,
             :occurs_on,
             :occurs_frequency,
             :occurs_at,
             :start_at,
             :duration,
             :active,
             :latitude,
             :longitude,
             :radius

  attribute :id do |object|
    object.uuid
  end

  attribute :description do |object|
    object.description.to_s
  end

  attribute :occurs_frequency do |object|
    object.i18n_occurs_frequency.to_sentence
  end

  attribute :occurs_at do |object|
    object.occurs_at&.iso8601
  end

  attribute :start_at do |object|
    object.start_at&.iso8601
  end

  attribute :created_at do |object|
    object.created_at.iso8601
  end

  attribute :updated_at do |object|
    object.updated_at.iso8601
  end

  attribute :radius do |object|
    object.radius.to_i
  end

  has_many :participants, if: Proc.new { |record, params| params[:include] == "participant" }
end
