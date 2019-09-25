# frozen_string_literal: true

module API
  class AuthenticateUsersController < ApplicationController
    def create
      result = API::CreateUserAuthentication.call(attributes: authentication_params)

      respond_to do |format|
        format.json { render result.response }
        format.json_api_v1 { render result.response }
      end
    end

    private
      def authentication_params
        params.permit(:email, :password)
      end
  end
end
