# frozen_string_literal: true

require "application_system_test_case"

class InvitationTest < ApplicationSystemTestCase
  def setup
    login_as users(:owner)
    visit activities_path
    book_club = activities(:book_club)
    find("td", text: book_club.name).click
  end

  def test_it_can_invite_a_participant
    find("button[data-action='modals#openModal']").click
    fill_in "participant[email]", with: "participant_user@checkinar.io"
    find(:css, "input[id='participant_roles_mask_attender']").set(true)
    find("input[data-disable-with='#{I18n.t("shared.buttons.invite")}']").click

    assert page.has_content?("participant_user@checkinar.io")
  end


  def test_it_can_not_invite_a_participant_whitout_an_email
    find("button[data-action='modals#openModal']").click
    find(:css, "input[id='participant_roles_mask_attender']").set(true)
    find("input[data-disable-with='#{I18n.t("shared.buttons.invite")}']").click

    assert page.has_content?(I18n.t("errors.messages.blank"))
  end

  def test_it_can_not_invite_a_participant_with_an_invalid_email
    find("button[data-action='modals#openModal']").click
    find(:css, "input[id='participant_roles_mask_attender']").set(true)
    fill_in "participant[email]", with: "invalid participant@checkinar.io"
    find("input[data-disable-with='#{I18n.t("shared.buttons.invite")}']").click

    assert page.has_content?(I18n.t("errors.messages.invalid"))
  end

  def test_it_can_not_invite_a_participant_without_defining_a_role
    find("button[data-action='modals#openModal']").click
    fill_in "participant[email]", with: "participant_usr@checkinar.io"
    find("input[data-disable-with='#{I18n.t("shared.buttons.invite")}']").click

    assert page.has_content?(I18n.t("activerecord.errors.models.participant.attributes.roles_mask.choose_one"))
  end
end
