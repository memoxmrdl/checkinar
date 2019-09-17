# frozen_string_literal: true

module Management
  class BaseController < ApplicationController
    before_action :authenticate_management!

    private
      def authenticate_management!
        unless user_signed_in? && current_user.is_owner? || current_user.is_leader?
          redirect_to root_path, alert: t(:prohibited_access, scope: "generic.alerts")
        end
      end
  end
end
