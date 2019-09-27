# frozen_string_literal: true

require "test_helper"

class AttendancesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
  end

  def test_it_gets_index_attendances_of_attender
    sign_in @attender

    get attendances_path

    assert_response :success
  end

  def test_it_gets_index_attendances_with_dates_range
    sign_in @attender

    get attendances_path, params: { attendance: { date_range: "#{(Time.zone.now - 1.month).to_date} - #{Time.zone.now.to_date}" } }

    assert_response :success
  end
end
