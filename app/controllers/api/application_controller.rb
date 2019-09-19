# frozen_string_literal: true

module API
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    attr_reader :current_organization
    before_action :authenticate_by_token

    private
      def authenticate_by_token
        authenticate_or_request_with_http_token do |token, options|
          @current_organization ||= Organization.find_by(api_key: token)
        end
      end
  end
end
