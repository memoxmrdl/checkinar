# frozen_string_literal: true

require "application_system_test_case"

class OrganizationTest < ApplicationSystemTestCase
  setup do
    login_as users(:owner)
    visit root_path
  end

  test "logged user can registry an organization" do
    click_link "Agregar organización"
    fill_in "Nombre", with: "Acme"
    click_button "Registrar"

    assert page.has_content?("Organización creada correctamente")
  end

  test "logged user can access to organization dashboard" do
    click_link "Organizaciones"
    click_link "Umbrella"

    assert page.has_content?("Umbrella")
    assert page.has_content?("Editar")
  end

  test "logged user can udpate an organization" do
    click_link "Organizaciones"
    click_link "Umbrella"
    click_link "Editar"
    fill_in "Nombre", with: "New organization"
    click_button "Actualizar"

    assert page.has_content?("Organización actualizada correctamente")
  end

  test "logged user can not update an organization whith an empty name" do
    click_link "Organizaciones"
    click_link "Umbrella"
    click_link "Editar"
    fill_in "Nombre", with: ""
    click_button "Actualizar"

    assert page.has_content?("Error actualizando la organización")
  end
end
