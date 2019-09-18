# frozen_string_literal: true

require_dependency "custom_form_builder"

ActionView::Base.default_form_builder = CustomFormBuilder

module ApplicationHelper
  def real_root_path
    return root_path unless user_signed_in?

    if user_signed_in? && current_user.is_owner? || current_user.is_leader?
      management_root_path
    elsif current_user.is_attender?
      attender_root_path
    end
  end

  def model_plural_name(model)
    return "" if model.nil?

    model.model_name.human.pluralize(I18n.locale)
  end

  def model_singular_name(model)
    return "" if model.nil?

    model.model_name.human
  end

  def date_daynames_options
    (0..6).map do |day_number|
      [
        I18n.t("date.day_names", locale: :en)[day_number].downcase,
        I18n.t("date.day_names", locale: I18n.default_locale)[day_number].capitalize
      ]
    end
  end

  def duration_options
    [
      ["15 Minutos", 15],
      ["30 Minutos", 30],
      ["1 Hora", 60],
      ["2 Horas", 120]
    ]
  end

  def resource_attribute_and_value(resource = nil, attribute = nil)
    value = resource.send(attribute)

    content_tag :div, class: "field" do
      concat(content_tag(:label, resource.class.human_attribute_name(attribute), class: "label"))
      concat(
        content_tag(:div, class: "control") do
          content_tag(:p, value)
        end
      )
    end
  end
end
