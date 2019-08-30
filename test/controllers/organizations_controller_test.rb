# frozen_string_literal: true

require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "no logged user can not create an organization" do
    get new_organization_path

    assert_redirected_to new_user_session_path
    assert I18n.t("devise.failure.unauthenticated"), flash[:notice]
  end

  test "logged user can access to new organization path" do
    login_as users(:owner)

    get new_organization_path

    assert_response :success
  end

  test "logged user can create a new organization" do
    login_as users(:owner)
    post organizations_path, params: { organization: { name: "Acme" } }

    assert_redirected_to root_path
    assert "Organización creada correctamente", flash[:notice]
  end

  test "loggen user can update an organization" do
    login_as users(:owner)
    umbrella = organizations(:umbrella)
    patch organization_path(umbrella), params: { organization: { name: "New organization" } }

    assert_redirected_to root_path
    assert "Organización actualizada correctamente", flash[:notice]
  end

  test "logged user can not update an organization with an empty name" do
    login_as users(:owner)
    umbrella = organizations(:umbrella)
    patch organization_path(umbrella), params: { organization: { name: "" } }

    assert_response :success
    assert "Error actualizando la organización", flash[:alert]
  end
end
