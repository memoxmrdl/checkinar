# frozen_string_literal: true

module API
  class IndexAttendancesUsers
    include Interactor

    attr_reader :activity

    def call
      context.response = {}

      find_activity
      valid_params
      resolve_collection
    end

    private
      def find_activity
        @activity = context.organization.activities.find_by!(uuid: context.params[:activity_id])
      rescue ActiveRecord::RecordNotFound
        context.response[:json] = ErrorSerializer.new(:record_not_found, is_collection: false)
        context.response[:status] = :not_found
        context.fail!
      end

      def valid_params
        context.options = {}

        if ["asc", "desc"].include?(context.params[:order_by])
          context.options[:order_by] = context.params[:order_by]
        end

        if context.params[:start_date] && !valid_date?(context.params[:start_date])
          context.response[:json] = ErrorSerializer.new(:invalid_start_date, is_collection: false)
          context.response[:status] = :bad_request
          context.fail!
        end

        if context.params[:end_date] && !valid_date?(context.params[:end_date])
          context.response[:json] = ErrorSerializer.new(:invalid_end_date, is_collection: false)
          context.response[:status] = :bad_request
          context.fail!
        end

        context.options[:limit] = context.params[:limit] if context.params[:limit].present?
        context.options[:start_date] = context.params[:start_date].to_date if context.params[:start_date].present?
        context.options[:end_date] = context.params[:end_date].to_date if context.params[:end_date].present?
      end

      def valid_date?(date)
        Date.parse(date)
        true
      rescue ArgumentError
        false
      end

      def resolve_collection
        collection = activity.users.by_attendances(activity.id, context.options)

        context.response[:json] = UserSerializer.new(collection)
      end
  end
end
