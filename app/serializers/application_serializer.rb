# frozen_string_literal: true

class ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  def to_json(*)
    Oj.dump(serializable_hash)
  end
end
