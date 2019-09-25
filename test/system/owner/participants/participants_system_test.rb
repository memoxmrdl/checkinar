# frozen_string_literal: true

require "application_system_test_case"

class PartipantTest < ApplicationSystemTestCase
  def test_it_can_delete_a_participan
    login_as users(:owner)
    visit activities_path
    book_club = activities(:book_club)
    participant = participants(:attender)

    find("td", text: book_club.name).click
    find("a[href='/activities/#{book_club.id}/participants/#{participant.id}']").click

    assert page.has_content?(I18n.t("participants.destroy.notice"))
  end
end
