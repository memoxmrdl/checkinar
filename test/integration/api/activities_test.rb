# frozen_string_literal: true

require "test_helper"

class API::ActivitiesTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
  end

  def test_activities_list_of_attender_authorized
    authenticate @attender

    get activities_path, headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Actividades-200"
  end

  def test_retrieve_activity_of_attender_authorized
    authenticate @attender

    activity = activities(:book_club)

    get activity_path(id: activity.uuid), headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Actividad-200-include-is-not-set"
  end

  def test_retrieve_activity_fail_with_not_found
    authenticate @attender

    get activity_path(id: "not_found"), headers: headers

    assert_response :not_found
    assert_matches_json_schema response, "GET-Actividad-404-include-is-not-set"
  end

  def test_retrieve_activity_of_attender_authorized_with_include_participant
    authenticate @attender

    activity = activities(:book_club)

    get activity_path(id: activity.uuid, include: "participant"), headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Actividad-200-include-is-set-to-participant"
  end
end
