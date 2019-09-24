# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  api_key    :string           not null
#


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
