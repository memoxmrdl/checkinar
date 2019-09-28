# frozen_string_literal: true

module API
  class CreateUserAuthentication
    include Interactor

    attr_reader :user

    def call
      context.response = { status: :unauthorized }

      find_user
      validate_user
      create_authentication
    end

    private
      def find_user
        @user = User.find_for_database_authentication(email: context.attributes[:email])

        unless user
          context.response[:json] = ErrorSerializer.new(:not_authenticated, is_collection: false)
          context.fail!
        end
      end

      def validate_user
        unless user.valid_password?(context.attributes[:password])
          context.response[:json] = ErrorSerializer.new(:not_authenticated, is_collection: false)
          context.fail!
        end
      end

      def create_authentication
        context.response[:status] = :created
        context.response[:json] = UserAuthenticatedSerializer.new(user)
      end
  end
end
