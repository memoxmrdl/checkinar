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

  test "organization can have a logo" do
    acme = Organization.new(name: "Acme")
    acme.logo.attach(io: File.open("#{Rails.root}/test/fixtures/files/gitlab.png"),
                          filename: "gitlab.png",
                          content_type: "image/png")

    assert acme.valid?
  end
end
