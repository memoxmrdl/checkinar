# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @subject = User.new
  end

  def test_it_creates_valid
    @subject.email = "correo@checkinar.io"
    @subject.full_name = "Dummy Name"
    @subject.password = "12345678"
    @subject.roles << :normal
    @subject.organization = organizations(:michelada)

    assert @subject.save
  end

  def test_it_create_invalid
    assert_not @subject.save
  end
end
