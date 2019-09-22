# frozen_string_literal: true

module API
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    attr_reader :current_organization
    attr_reader :current_user

    before_action :authenticate_by_token

    protected
      def authenticate_user!
        user_not_authenticated unless user_authenticated_user?
        user_id = user_authentication_decoce_token[:user_id].to_i
        @current_user = current_organization.users.find(user_id)
      rescue ActiveRecord::RecordNotFound, JWT::VerificationError, JWT::DecodeError
        user_not_authenticated
      end

    private
      def authenticate_by_token
        authenticate_or_request_with_http_token do |token, options|
          @current_organization ||= Organization.find_by(api_key: token)
        end
      end

      def user_authentication_token
        @authorization_token ||= request.headers["Authorization"]
      end

      def user_authentication_decode_token
        @decode_token ||= JsonWebToken.decode(user_authentication_token)
      end

      def user_authenticated_token?
        user_authentication_decode_token[:user_id].present?
      end

      def user_not_authenticated
        render json: { errors: "Not authenticated" }, status: :unauthorized
      end
  end
end
