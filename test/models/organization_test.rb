# frozen_string_literal: true

require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  test "organization is not valid without a name" do
    acme = Organization.new

    assert_not acme.valid?
  end

  test "organization is valid with a name" do
    acme = Organization.new(name: "Acme")

    assert acme.valid?
  end
end
