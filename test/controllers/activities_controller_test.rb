# frozen_string_literal: true

require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @owner = users(:owner)
    @leader = users(:leader)
    @activity = activities(:book_club)
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

  def test_it_gets_index_activities_as_owner
    sign_in @owner

    get activities_path

    assert_response :success
  end

  def test_it_gets_index_activities_as_leader
    sign_in @leader

    get activities_path

    assert_response :success
  end

  def test_it_shows_activity_owner
    sign_in @owner

    get activity_path(@activity)

    assert_response :success
  end

  def test_it_shows_activity_leader
    sign_in @leader

    get activity_path(@activity)

    assert_response :success
  end

  def test_it_shows_responds_redirect_when_an_activity_doesnt_exists_as_owner
    sign_in @owner

    get activity_path(id: "not_found")

    assert_response :redirect
  end

  def test_it_shows_responds_redirect_when_an_activity_doesnt_exists_leader
    sign_in @leader

    get activity_path(id: "not_found")

    assert_response :redirect
  end

  def test_it_news_activity_as_owner
    sign_in @owner

    get new_activity_path

    assert_response :success
  end

  def test_it_news_activity_responds_redirect_as_leader
    sign_in @leader

    get new_activity_path

    assert_response :redirect
  end

  def test_it_creates_activity_as_owner
    sign_in @owner

    assert_difference "Activity.count" do
      post activities_path, params: @params
    end
  end

  def test_it_responds_unproccesable_entity_when_creates_an_activity_as_owner
    sign_in @owner

    @params[:activity][:name] = ""

    post activities_path, params: @params

    assert_response :unprocessable_entity
  end

  def test_it_creates_activity_responds_redirect_as_leader
    sign_in @owner

    assert_difference "Activity.count" do
      post activities_path, params: @params
    end
  end

  def test_it_edits_activity_as_owner
    sign_in @owner

    activity = activities(:book_club)

    get edit_activity_path(activity)

    assert_response :success
  end

  def test_it_edits_activity_as_leader
    sign_in @leader

    activity = activities(:book_club)

    get edit_activity_path(activity)

    assert_response :success
  end

  def test_it_updates_activity_as_owner
    sign_in @owner

    activity = activities(:book_club)

    patch activity_path(activity), params: { activity: { name: "Movie Club" } }

    assert_response :redirect
  end

  def test_it_updates_activity_as_leader
    sign_in @leader

    activity = activities(:book_club)

    patch activity_path(activity), params: { activity: { name: "Movie Club" } }

    assert_response :redirect
  end

  def test_it_updates_activity_responds_unprocessable_entity_as_owner
    sign_in @owner

    activity = activities(:book_club)

    patch activity_path(activity), params: { activity: { name: "" } }

    assert_response :unprocessable_entity
  end

  def test_it_updates_activity_responds_unprocessable_entity_as_leader
    sign_in @owner

    activity = activities(:book_club)

    patch activity_path(activity), params: { activity: { name: "" } }

    assert_response :unprocessable_entity
  end

  def test_it_updates_activity_not_found_responds_redirect_as_owner
    sign_in @owner

    patch activity_path(id: "not_found"), params: { activity: { name: "Movie Club" } }

    assert_response :redirect
  end

  def test_it_updates_activity_not_found_responds_redirect_as_leader
    sign_in @leader

    patch activity_path(id: "not_found"), params: { activity: { name: "Movie Club" } }

    assert_response :redirect
  end

  def test_it_updates_activity_responds_redirect_when_an_user_attender_wants_update
    sign_in users(:attender)

    activity = activities(:book_club)

    patch activity_path(activity), params: { activity: { name: "Movie Club" } }

    assert_response :redirect
  end
end
