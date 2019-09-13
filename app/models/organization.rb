# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :activities

  validates :name, presence: true

  has_one_attached :logo
end
