# frozen_string_literal: true

require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  def setup
    login_as users(:owner)
    visit activities_path
  end

  def test_owner_can_create_an_actitivity
    find("a[href='/activities/new']").click
    fill_in "activity[name]", with: "Crosfit"
    find("option[value='more_than_once']").click
    find(:css, "input[id='activity_occurs_frequency_sunday']").set(true)

    fill_in "activity_start_at", with: "09:00"
    within "#activity_duration" do
      find("option[value='15']").click
    end
    find("input[type='submit']").click

    assert page.has_content?(I18n.t("activities.create.notice"))
  end

  def owner_can_edit_an_activity
    book_club = activities(:book_club)

    find("td", text: book_club.name).click
    find("a[href='/activities/#{book_club.id}/edit']").click
    fill_in "activity[name]", with: "Learning"
    find("input[type='submit']").click

    assert page.has_content?(I18n.t("activities.update.notice"))
  end

  def test_owner_can_not_update_an_activity_if_name_not_defined
    book_club = activities(:book_club)

    find("td", text: book_club.name).click
    find("a[href='/activities/#{book_club.id}/edit']").click
    fill_in "activity[name]", with: ""
    find("input[type='submit']").click

    assert page.has_content?(I18n.t("activities.update.alert"))
  end
end
