# frozen_string_literal: true

class APIConstraint
  def self.matches?(request)
    /^application\/json$/.match?(request.headers["ACCEPT"])
  end
end
