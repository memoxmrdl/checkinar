# frozen_string_literal: true

module API
  class AuthenticateUsersController < ApplicationController
    def create
      result = API::CreateUserAuthentication.call(attributes: authentication_params)

      render result.response
    end

    private
      def authentication_params
        params.permit(:email, :password)
      end
  end
end
