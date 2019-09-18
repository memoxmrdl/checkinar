# frozen_string_literal: true

require "test_helper"

class API::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @activity = activities(:book_club)
    @organization_token = { ACCEPT: "application/json",
                            Authorization: "Token token=#{@activity.organization.api_key}" }
    @params = {
      activity: {
        name: "English Class",
        description: "Quickly english courses",
        occurs_on: Activity.occurs_ons[:more_than_once],
        occurs_frequency: ["monday", "friday", "saturday"],
        occurs_at: Time.zone.now.to_date,
        start_at: Time.zone.now,
        duration: 60
      }
    }
  end

  def test_it_returns_an_actity
    get activity_path(@activity), as: :json,
                                  headers: @organization_token

    assert_response :success
  end

  def test_it_returns_all_activities
    get activities_path, as: :json,
                       headers: @organization_token

    assert_response :success
  end

  def test_it_updates_an_actitivy
    patch activity_path(@activity), as: :json,
                                  headers: @organization_token,
                                  params: @params

    assert_response :success
  end

  def test_it_creates_an_activity
    post activities_path, as: :json,
                          headers: @organization_token,
                          params: @params

    assert_response :success
  end

  def test_it_creates_an_activity_with_errors_returns_unprocessable_entity
    post activities_path, as: :json,
                          headers: @organization_token,
                          params: { activity: { duration: 10 } }

    assert_response :unprocessable_entity
  end

  def test_it_updates_an_activity_with_errors_returns_unprocessable_entity
    patch activity_path(@activity), as: :json,
                          headers: @organization_token,
                          params: { activity: { duration: 10, name: nil } }

    assert_response :unprocessable_entity
  end
end
