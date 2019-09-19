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
             :radius,
             :created_at,
             :updated_at
end
