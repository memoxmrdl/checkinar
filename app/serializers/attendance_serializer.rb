# frozen_string_literal: true

class AttendanceSerializer < ApplicationSerializer
  attributes :activity_id,
             :user_id,
             :attended_at,
             :status,
             :latitude,
             :longitude
end
