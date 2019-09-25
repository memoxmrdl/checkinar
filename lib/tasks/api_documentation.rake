# frozen_string_literal: true

require "erb"
require "i18n"

namespace :api do
  desc "Generate API documentation"
  task :documentation do
    input_file = "docs/api/documentation.md.erb"
    input_file_compiled = "docs/api/documentation.md"
    output_file = "public/api/documentation.html"

    puts "Generating api documentation from #{input_file}"
    system("erb #{input_file} > #{input_file_compiled}")
    system("bin/yarn run aglio --theme-template triple --theme-variables flatly  -i #{input_file_compiled}  -o #{output_file}")
    # system("rm #{input_file_compiled}")
    puts "Documentation is ready at #{output_file}"
  end

  desc "Generate JSON schemas"
  task :schemas do
    schemas_path = "test/support/schemas"
    input_file = "docs/api/documentation.md"
    output_file = "test/support/schemas/schemas.json"

    puts "Generating api schemas from #{input_file}"
    system("bin/yarn run apib2json --pretty -i #{input_file} -o #{output_file}")

    if File.exist?(output_file)
      file_path = Pathname.new(output_file)
      JSON.parse(file_path.read).each_pair do |group, actions|
        actions.each do |action|
          next if action.dig("meta", "type") != "response"

          verb = group.scan(/\[(.*)\]/).flatten.first
          name = "#{verb}-#{I18n.transliterate(action.dig('meta', 'group'))}(#{action.dig('meta', 'statusCode')})#{action.dig('meta', 'title')&.gsub(/ /, '-')}".
            sub(/\{.*\}/, "").gsub(/\(|\)/, "-").gsub(/^-|-$/, "")
          puts "Writing #{name}"
          File.open("#{schemas_path}/#{name}.json", "w") { |file| file.write(action.dig("schema").to_json) }
        end
      end
    end

    puts "Schemas are ready at #{schemas_path}"
  end
end
