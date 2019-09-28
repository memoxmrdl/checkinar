# frozen_string_literal: true

require_dependency "custom_form_builder"

ActionView::Base.default_form_builder = CustomFormBuilder

module ApplicationHelper
  def real_root_path
    return root_path unless user_signed_in?

    activities_path
  end

  def model_plural_name(model)
    return "" if model.nil?

    model.model_name.human.pluralize(I18n.locale)
  end

  def model_singular_name(model)
    return "" if model.nil?

    model.model_name.human
  end

  def duration_options
    [
      [t(:fifteen, scope: :duration_minutes), 15],
      [t(:thirty, scope: :duration_minutes), 30],
      [t(:hour, scope: :duration_minutes), 60],
      [t(:two_hours, scope: :duration_minutes), 120]
    ]
  end

  def resource_attribute_and_value(resource = nil, attribute = nil, format: :default, label_text: nil, &block)
    if block_given?
      value = capture(&block)
    else
      value = resource.send(attribute)
      value = if value.blank?
        format = :default
        t(:n_a, scope: :generic)
      else
        value
      end

      case format
      when :default
        value
      when :date
        value = l(value)
      when :time
        value = l(value, format: :only_time)
      when :enum
        value = resource.send("i18n_#{attribute}")
      when :boolean
        value = I18n.t(resource.send(attribute), scope: "generic.true_or_false")
      end
    end

    label_text = label_text.present? ? label_text : resource.class.human_attribute_name(attribute)

    content_tag :div, class: "field" do
      concat(content_tag(:label, label_text, class: "label"))
      concat(
        content_tag(:div, class: "control") do
          content_tag(:p, value)
        end
      )
    end
  end

  def see_record_cell(record_path, content, html_options = {})
    html_options[:class] = "cursor-pointer #{html_options[:class]}"
    html_options["data-turbolinks-eval"] = true
    html_options[:onclick] = "Turbolinks.enableTransitionCache(false); Turbolinks.visit('#{record_path}');"

    content_tag :td, html_options do
      content
    end
  end

  def figure_image_tag(image, options = {})
    image = if image.attached? && !image.record.errors.any?
      image = image.variant(resize_to_limit: options[:variant_resize].split("x").map(&:to_i)).processed if options[:variant_resize]

      url_for(image)
    else
      asset_pack_path("media/application/images/placeholder.png")
    end

    wrapper_class = "image #{options.delete(:wrapper_class)}"

    content_tag(:figure, class: wrapper_class) do
      image_tag(image, options)
    end
  end
end
