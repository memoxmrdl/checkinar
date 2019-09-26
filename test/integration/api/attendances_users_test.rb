# frozen_string_literal: true

require "test_helper"

class API::AttendancesUsersTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
    @activity = activities(:traguitos)
  end

  def test_it_returns_users_of_top_10_the_most_attendances_of_activity
    authenticate @attender

    get attendances_users_path(activity_id: @activity.uuid), headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Asistencia de usuarios-200"
  end
end
