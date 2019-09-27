# frozen_string_literal: true

require "test_helper"

class API::AttendancesTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
    @activity = activities(:book_club)
    @params = {
      user_id: @attender.uuid,
      activity_id: @activity.uuid
    }
  end

  def test_it_creates_an_attendance_of_attender_on_activity
    authenticate @attender

    @params[:latitude] = 19.257567
    @params[:longitude] = -103.719110

    post attendances_path, params: @params, headers: headers

    assert_response :created
    assert_matches_json_schema response, "POST-Asistencias-201"
  end

  def test_it_creates_an_attendance_of_attender_on_activity_free
    authenticate @attender

    @params[:activity_id] = activities(:fitness).uuid

    post attendances_path, params: @params, headers: headers

    assert_response :created
    assert_matches_json_schema response, "POST-Asistencias-201"
  end

  def test_it_wont_create_an_attendance_because_is_out_of_range_date
    authenticate @attender

    @params[:user_id] = users(:pedro).uuid
    @params[:activity_id] = activities(:traguitos).uuid

    post attendances_path, params: @params, headers: headers

    assert_response :unprocessable_entity
    assert_matches_json_schema response, "POST-Asistencias-401"
  end

  def test_it_wont_create_an_attendance_because_is_out_of_location
    authenticate @attender

    @params[:latitude] = 18.257567
    @params[:longitude] = -103.719110

    post attendances_path, params: @params, headers: headers

    assert_response :unprocessable_entity
    assert_matches_json_schema response, "POST-Asistencias-401"
  end
end
