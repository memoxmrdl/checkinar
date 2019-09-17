# frozen_string_literal: true

require_dependency "custom_form_builder"

ActionView::Base.default_form_builder = CustomFormBuilder

module ApplicationHelper
end
