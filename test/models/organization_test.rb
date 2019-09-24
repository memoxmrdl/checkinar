# frozen_string_literal: true

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
