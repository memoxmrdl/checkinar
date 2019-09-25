# frozen_string_literal: true

class PointInsideRadius
  attr_reader :check_location, :center_location, :kilometers

  KY = 40000 / 360

  def initialize(check_location = {}, center_location = {}, meters = 0)
    @kilometers = meters.to_f / 1000
    @check_location = check_location
    @center_location = center_location
  end

  def is_inside?
    calculate_are_points_near
  end

  private
    def calculate_are_points_near
      kx = Math.cos((Math::PI * center_location[:latitude] / 180.0)) * KY

      dx = (center_location[:longitude] - check_location[:longitude]).abs * kx
      dy = (center_location[:latitude] - check_location[:latitude]).abs * KY

      Math.sqrt(dx * dx + dy * dy) <= kilometers
    end
end
