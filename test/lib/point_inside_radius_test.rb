# frozen_string_literal: true

require "test_helper"

class PointInsideRadiusTest < ActiveSupport::TestCase
  def setup
    @subject = PointInsideRadius
    # https://www.google.com/maps/place/michelada.io/@19.266651,-103.7179345,19z/data=!4m8!1m2!2m1!1smichelada!3m4!1s0x0:0x3dbaa3579153065f!8m2!3d19.266788!4d-103.7175389
    @michelada_location = { latitude: 19.266651, longitude: -103.7179345 }
    @radius_meters = 25
  end

  def test_current_location_is_inside_at_michelada
    # https://www.google.com/maps/search/michelada/@19.266542,-103.718041,19z
    current_location = { latitude: 19.266542, longitude: -103.718041 }

    assert @subject.new(current_location, @michelada_location, @radius_meters).is_inside?
  end

  def test_iam_not_inside_at_michelada
    # https://www.google.com/maps/place/MIinisuper+El+Golfito/@19.2666211,-103.7172217,20.6z/data=!4m8!1m2!2m1!1smichelada!3m4!1s0x84255ac5fc475c67:0xee378f4e77a4fcf5!8m2!3d19.2668934!4d-103.7170067
    minisuper_golfito_location = { latitude: 19.2666211, longitude: -103.7172217 }

    assert_not @subject.new(minisuper_golfito_location, @michelada_location, @radius_meters).is_inside?
  end
end
