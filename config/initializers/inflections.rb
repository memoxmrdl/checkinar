# frozen_string_literal: true

# Grabbed from https://github.com/davidcelis/inflections/blob/master/lib/inflections/es.rb

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym "API"
end

ActiveSupport::Inflector.inflections(:es) do |inflect|
  inflect.clear :all

  inflect.plural /([^djlnrs])([A-Z]|_|$)/, '\1s\2'
  inflect.plural /([djlnrs])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /(.*)z([A-Z]|_|$)$/i, '\1ces\2'

  inflect.singular /([^djlnrs])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([djlnrs])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /(.*)ces([A-Z]|_|$)$/i, '\1z\2'

  inflect.irregular("el", "los")
end
