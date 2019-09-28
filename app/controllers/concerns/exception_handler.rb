# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private
    def record_not_found
      render json: ErrorSerializer.new(:record_not_found, is_collection: false), status: :not_found
    end

    def user_not_authenticated
      render json: ErrorSerializer.new(:not_authenticated, is_collection: false), status: :unauthorized
    end
end
