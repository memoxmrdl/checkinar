# frozen_string_literal: true

require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  def setup
    login_as users(:owner)

    visit activities_path
  end

  def test_owner_can_create_an_actitivity
    click_link "Nueva Actividad"

    within "form" do
      fill_in "Nombre", with: "Crossfit"
      select "Días de la semana", from: "Sucede"
      check "Lunes"
      fill_in "Hora", with: "09:00AM"
      select "15 Min", from: "Tiempo de duración"
      click_button "Crear Actividad"
    end

    assert page.has_content?(I18n.t("activities.create.notice"))
  end

  def owner_can_edit_an_activity
    book_club = activities(:book_club)

    visit edit_activity_path(book_club)

    within "form" do
      fill_in "Descripción", with: "Actividad en BodyTech"
      click_button "Actualizar Actividad"
    end

    assert page.has_content?(I18n.t("activities.update.notice"))
  end

  def test_owner_can_not_update_an_activity_if_name_not_defined
    book_club = activities(:book_club)

    visit edit_activity_path(book_club)

    within "form" do
      fill_in "Nombre", with: ""
      click_button "Actualizar Actividad"
    end

    assert page.has_content?(I18n.t("activities.update.alert"))
  end
end
