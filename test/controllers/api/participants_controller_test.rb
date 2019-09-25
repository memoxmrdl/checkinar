# frozen_string_literal: true

require "test_helper"

class API::ParticipantsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
    @participant = participants(:attender)
  end

  def test_it_returns_a_participant_of_user
    authenticate @attender

    get participant_path(id: @participant.uuid), headers: headers

    assert_response :success
  end
end
