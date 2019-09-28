# frozen_string_literal: true

require "test_helper"

class API::AuthenticationUsersTest < ActionDispatch::IntegrationTest
  def setup
    @attender = users(:attender)
    @params = {
      email: @attender.email
    }
  end

  def test_it_creates_authentication
    @params[:password] = "12345678"

    post authenticate_users_path, params: @params, headers: headers

    assert_response :created
    assert_matches_json_schema response, "POST-Autenticacion\ de\ Usuarios-201"
  end

  def test_it_wont_create_authentication_with_email_invalid
    @params[:email] = "thor@checkinar"

    post authenticate_users_path, params: @params, headers: headers

    assert_response :unauthorized
    assert_matches_json_schema response, "POST-Autenticacion\ de\ Usuarios-401"
  end

  def test_it_wont_create_authentication_with_password_invalid
    @params[:password] = "invalid"

    post authenticate_users_path, params: @params, headers: headers

    assert_response :unauthorized
    assert_matches_json_schema response, "POST-Autenticacion\ de\ Usuarios-401"
  end
end
