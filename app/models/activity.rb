# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :organization

  validates :name, presence: true
end
