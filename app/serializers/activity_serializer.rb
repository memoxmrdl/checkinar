# frozen_string_literal: true

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
