# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users
  has_many :activities

  validates :name, uniqueness: true, presence: true

  before_create :generate_api_key!

  def generate_api_key!
    api_key = SecureRandom.base58(32)

    if persisted?
      update_attribute :api_key, api_key
    else
      self.api_key = api_key
    end
  end
end
