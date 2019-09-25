# frozen_string_literal: true

require "application_system_test_case"

class  AttendancesTest < ApplicationSystemTestCase
  def test_it_can_confirm_an_attendace
    login_as users(:owner)
    visit activities_path
    traguitos = activities(:traguitos)
    attendance = attendances(:third)

    find("td", text: traguitos.name).click
    find("a[href='/activities/#{traguitos.id}/confirm_attendances/#{attendance.id}']").click

    assert page.has_content?(I18n.t("confirm_attendances.update.notice"))
  end
end
