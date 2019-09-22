# frozen_string_literal: true

require "test_helper"

class API::AuthenticateUsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @michelada = organizations(:michelada)
    @headers = {
      ACCEPT: "application/json",
      Authorization: "Token token=#{@michelada.api_key}"
    }
    @attender = users(:attender)
    @params = {
      email: @attender.email
    }
  end

  def test_it_creates_authentication
    @params[:password] = "12345678"

    post authenticate_users_path, params: @params, headers: @headers

    assert_response :created
  end

  def test_it_wont_create_authentication_with_email_invalid
    @params[:email] = "thor@checkinar"

    post authenticate_users_path, params: @params, headers: @headers

    assert_response :unauthorized
  end

  def test_it_wont_create_authentication_with_password_invalid
    @params[:password] = "invalid"

    post authenticate_users_path, params: @params, headers: @headers

    assert_response :unauthorized
  end
end
