# frozen_string_literal: true

require "test_helper"

class API::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:attender)
  end

  def test_it_returns_an_actity_of_current_user
    authenticate @user

    activity = activities(:book_club)

    @user.activities << activity

    get activity_path(activity), headers: headers

    assert_response :success
  end

  def test_it_returns_all_activities_of_current_user
    authenticate @user

    get activities_path, headers: headers

    assert_response :success
  end
end
