# frozen_string_literal: true

require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  def setup
    @subject = Activity.new
  end

  def it_creates_valid
    @subject.name = "Gym"
    @subject.organization = organizations(:michelada)

    assert @subject.save
  end

  def it_creates_invalid
    assert_not @subject.save
  end
end
