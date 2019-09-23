# frozen_string_literal: true

class Distance
  require "net/http"
  require "uri"
  MAPS_API_TOKEN = Rails.application.credentials.google_maps_api_key

  def self.meassure(activity_location, user_location)
    uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=#{activity_location}&destinations=#{user_location}&key=#{MAPS_API_TOKEN}")
    response = Net::HTTP.get_response(uri)
    json_response = JSON.parse(response.body)
    json_response.dig("rows", 0, "elements", 0, "distance", "value")
  end
end
