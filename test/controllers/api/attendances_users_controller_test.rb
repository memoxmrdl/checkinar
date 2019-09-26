# frozen_string_literal: true

require "test_helper"

class API::AttendancesUsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
    @activity = activities(:traguitos)
  end

  def test_it_returns_users_of_top_10_the_most_attendances_of_activity
    authenticate @attender

    get attendances_users_path(activity_id: @activity.uuid), headers: headers

    assert_response :success
  end

  def test_it_responds_not_found_when_activity_id_doesnt_exists
    authenticate @attender

    get attendances_users_path(activity_id: "not_found"), headers: headers

    assert_response :not_found
  end

  def test_it_responds_bad_request_when_start_date_nad_end_date_is_invalid
    authenticate @attender

    get attendances_users_path(activity_id: @activity.uuid, start_date: "invalid", end_date: "invalid"), headers: headers

    assert_response :bad_request
  end
end
