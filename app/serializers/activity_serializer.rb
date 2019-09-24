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

  attribute :start_at do |activity|
    I18n.l(activity.start_at, format: :only_time)
  end

  attribute :created_at do |activity|
    activity.created_at.to_s
  end

  attribute :updated_at do |activity|
    activity.updated_at.to_s
  end

  has_many :users, serializer: UserSerializer, if: Proc.new { |actitiy, params| params[:start_date] && params[:end_date] } do |activity, params|
    User.top_ten_participants(activity.id, params[:start_date], params[:end_date])
  end
end
