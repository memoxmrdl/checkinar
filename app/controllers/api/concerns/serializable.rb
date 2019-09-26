# frozen_string_literal: true

module API
  module Concerns
    module Serializable
      extend ActiveSupport::Concern

      included do
        before_action :serialize_collection, only: :index
        before_action :serialize_resource, only: :show
      end

      private
        def serialize_collection
          @serialized_collection = model_serializer_class.new(resolve_collection)
        end

        def serialize_resource
          @serialized_resource = model_serializer_class.new(find_resource, params: { include: params[:include] })
        end

        def current_scope
          current_user.send(plural_resource_name)
        end

        def resolve_collection
          current_scope.joins(collection_associations).where(collection_conditions)
        end

        def find_resource
          current_scope.joins(resource_associations).where(resource_conditions).find_by!(uuid: params[:id])
        end

        def singular_resource_name
          self.controller_name.singularize
        end

        def plural_resource_name
          self.controller_name
        end

        def model_serializer_class
          "#{singular_resource_name.classify}Serializer".constantize
        end

        def collection_associations
          [].freeze
        end

        def collection_conditions
          [].freeze
        end

        def resource_associations
          {}.freeze
        end

        def resource_conditions
          {}.freeze
        end
    end
  end
end
