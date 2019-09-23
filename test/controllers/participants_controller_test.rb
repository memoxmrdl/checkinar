# frozen_string_literal: true

require "test_helper"

class ParticipantsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @owner = users(:owner)
    @attender = users(:attender)
    @activity = activities(:book_club)
    @params = {
      participant: {
        email: @attender.email,
        roles_mask: ["attender"]
      }
    }
  end

  def test_it_creates_participant_on_activity
    sign_in @owner

    @params[:participant][:email] = "andres@checkinar.io"

    post activity_participants_path(@activity), params: @params

    assert_response :created
  end

  def test_it_wont_create_participant_when_email_is_incorrect
    sign_in @owner

    @params[:participant][:email] = "andrescheckinar.io"

    post activity_participants_path(@activity), params: @params

    assert_response :unprocessable_entity
  end

  def test_it_wont_creates_participant_when_roles_mask_is_empty
    sign_in @owner

    @params[:participant][:email] = "andres@checkinar.io"
    @params[:participant][:roles_mask] = []

    post activity_participants_path(@activity), params: @params

    assert_response :unprocessable_entity
  end

  def test_it_wont_create_participant_because_user_belongs_to_activity
    sign_in @owner

    post activity_participants_path(@activity), params: @params

    assert_response :unprocessable_entity
  end

  def test_it_wont_create_participant_because_activity_doesnt_exists
    sign_in @owner

    post activity_participants_path(activity_id: "not_found"), params: @params

    assert_response :forbidden
  end
end
