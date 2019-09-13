# frozen_string_literal: true

class Activity < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :organization

  validates :name, presence: true
end
