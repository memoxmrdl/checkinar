# frozen_string_literal: true

require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @owner = users(:owner)
    @params = {
      user: {
        full_name: "Steve Jobs",
        organization_attributes: {
          name: "Apple Inc"
        }
      }
    }
  end

  def test_it_updates_current_user_its_full_name
    sign_in @owner

    patch account_path, params: @params

    assert_equal @owner.reload.full_name, @params[:user][:full_name]
    assert_response :redirect
  end

  def test_it_updates_current_user_its_avatar
    sign_in @owner

    @params[:user][:avatar] = fixture_file_upload("files/is_flour.jpg", "image/jpg")

    patch account_path, params: @params

    assert_equal @owner.reload.full_name, @params[:user][:full_name]
    assert_response :redirect
  end

  def test_it_updates_curren_orgazation_its_name_when_is_owner
    sign_in @owner

    patch account_path, params: @params

    assert_equal @owner.organization.name, @params[:user][:organization_attributes][:name]
    assert_response :redirect
  end

  def test_it_wont_update_curren_orgazation_its_name_when_isnt_owner
    sign_in users(:leader)

    patch account_path, params: @params

    assert_not_equal @owner.organization.name, @params[:user][:organization_attributes][:name]
    assert_response :redirect
  end
end
