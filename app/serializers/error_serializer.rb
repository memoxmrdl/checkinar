class ErrorSerializer < ApplicationSerializer
  set_id do
    :error
  end

  attribute :errors do |record_or_error_key, params|
    if record_or_error_key && record_or_error_key.class.superclass.superclass == ActiveRecord::Base
      record_or_error_key.errors
    elsif record_or_error_key.is_a?(Symbol)
      I18n.t(record_or_error_key, scope: "api.errors")
    else
      params[:errors]
    end
  end
end
