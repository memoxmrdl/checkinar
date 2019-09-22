# frozen_string_literal: true

require "test_helper"

class API::AttendancesControllerTest < ActionDispatch::IntegrationTest
  def setup
    activity = activities(:book_club)
    user = users(:attender)
    user.activities << activity
    user.save
    @organization_token = { ACCEPT: "application/json",
                            Authorization: "Token token=#{activity.organization.api_key}" }
    @params = {
      activity_id: activity.id,
      user_id: user.id,
      latitude: 19.257560,
      longitude: -103.719119
    }
  end

  def test_it_create_attendance
    post attendances_path, as: :json, params: @params, headers: @organization_token

    assert_response :success
  end

  def test_it_does_not_create_attendance_if_user_is_out_of_range
    @params[:latitude] = 19.917560

    post attendances_path, as: :json, params: @params, headers: @organization_token

    assert_response :unprocessable_entity
  end
end
