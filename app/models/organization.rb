# frozen_string_literal: true

class Organization < ApplicationRecord
  validates :name, presence: true

  has_one_attached :logo
end
