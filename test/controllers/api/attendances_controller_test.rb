# frozen_string_literal: true

require "test_helper"

class API::AttendancesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:attender)
    @activity = activities(:book_club)
    @params = {
      activity_id: @activity.id,
      user_id: @user.id,
      latitude: 19.257560,
      longitude: -103.719119
    }
  end

  def test_it_create_attendance
    authenticate @user

    Distance.stubs(meassure: 1) do
      post attendances_path, params: @params, headers: headers

      assert_response :success
    end
  end

  def test_it_does_not_create_attendance_if_user_is_out_of_range
    authenticate @user

    @params[:latitude] = 19.917560

    post attendances_path, params: @params, headers: headers

    assert_response :unprocessable_entity
  end
end
