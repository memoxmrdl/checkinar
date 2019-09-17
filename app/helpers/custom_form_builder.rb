# frozen_string_literal: true

class CustomFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def field_with_label(attribute, type: :text_field, **options)
    css_class = options.dig(:class)
    label_class = options.dig(:label_class)
    error_class = object.errors.include?(attribute) ? :is_danger : ""

    options[:class] = "input #{error_class} #{css_class}".strip

    field_error = field_error_container(object.errors[attribute].first) if object.errors.include?(attribute)
    field_label = label(attribute, class: "label #{label_class}")
    field_input = self.send(type, attribute, **options)

    field_container(field_label, field_input, field_error)
  end

  def field_container(field_label, field_input, field_error = nil)
    control = content_tag(:div, class: "control") do
      raw(field_label + field_input)
    end

    content_tag(:div, class: "field") do
      raw(control + field_error)
    end
  end

  def field_error_container(error)
    return "" unless error

    content_tag(:p, error, class: "help is-danger")
  end

  def field_submit(value = nil, options = {})
    content_tag :div, class: "field" do
      content_tag :div, class: "control" do
        submit(value, options)
      end
    end
  end
end
