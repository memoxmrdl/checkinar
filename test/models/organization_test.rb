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


require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @subject = Organization.new
  end

  def test_it_creates_valid
    @subject.name = "michelada gdl"

    assert @subject.save
  end

  def test_it_creates_invalid
    assert_not @subject.save
  end
end
