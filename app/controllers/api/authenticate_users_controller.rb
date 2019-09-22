# frozen_string_literal: true

module API
  class AuthenticateUsersController < ApplicationController
    def create
      result = API::CreateUserAuthentication.call(organization: current_organization, attributes: authentication_params)

      render result.response
    end

    private
      def authentication_params
        params.permit(:email, :password)
      end
  end
end
