# frozen_string_literal: true

module I18nEnumrable
  extend ActiveSupport::Concern

  class_methods do
    def i18n_enum_attribute(attribute)
      build_i18n_enum_methods(attribute)
    end

    private
      def build_i18n_enum_methods(attribute)
        define_method "i18n_#{attribute}" do
          return unless send(attribute)

          I18n.t(send(attribute), scope: "enums.models.#{self.class.name.underscore}.attributes.#{attribute}")
        end

        define_singleton_method "i18n_#{attribute.to_s.pluralize}" do
          self.send(attribute.to_s.pluralize).each_with_object({}) do |enum, memo|
            memo[enum.second] = I18n.t(enum.second, scope: "enums.models.#{self.name.underscore}.attributes.#{attribute}")
          end
        end
      end
  end
end
