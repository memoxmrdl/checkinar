# frozen_string_literal: true

module API
  class ApplicationController < ActionController::Base
    include ExceptionHandler

    skip_before_action :verify_authenticity_token

    attr_reader :current_organization
    attr_reader :current_user

    protected
      def authenticate_user!
        authenticate_or_request_with_http_token do |token, options|
          @current_user ||= AuthorizeUserRequest.call(token)
        end
      end
  end
end
