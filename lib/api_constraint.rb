# frozen_string_literal: true

class APIConstraint
  def self.matches?(request)
    request.headers["ACCEPT"].match?(/\A(application\/json|application\/vnd\.creditar\.v\d\+json)\z/)
  end
end
