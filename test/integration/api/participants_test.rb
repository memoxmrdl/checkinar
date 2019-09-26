# frozen_string_literal: true

require "test_helper"

class API::ParticipantsTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
    @participant = participants(:attender)
  end

  def test_participants_list_of_attender
    authenticate @attender

    get participants_path, headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Participaciones-200"
  end

  def test_participants_list_of_attender_and_filter_by_activity_id
    authenticate @attender

    get participants_path(activity_id: activities(:book_club).uuid), headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Participaciones-200"
  end

  def test_retrieve_participant_of_attender_authorized
    authenticate @attender

    get participant_path(id: @participant.uuid), headers: headers

    assert_response :success
    assert_matches_json_schema response, "GET-Participacion-200"
  end

  def test_retrieve_participant_fail_with_not_found
    authenticate @attender

    get participant_path(id: "not_found"), headers: headers

    assert_response :not_found
    assert_matches_json_schema response, "GET-Participacion-404"
  end
end
