# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_organization
    @_organization ||= current_user&.organization
  end

  def after_sign_in_path_for(resource)
    activities_path
  end

  private
    def user_not_authorized
      flash[:alert] = t(:no_authorized, scope: :pundit)

      redirect_to(request.referrer || root_path)
    end

    def record_not_found
      flash[:alert] = t(:record_not_found, scope: "generic.flash")

      redirect_to(action: :index) && return if self.action_methods.include? "index"
      redirect_to root_path
    end
end
