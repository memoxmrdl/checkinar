# frozen_string_literal: true

require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  def setup
    @subject = Activity.new
  end

  def test_it_creates_valid
    @subject.name = "Gym"
    @subject.organization = organizations(:michelada)

    assert @subject.save
  end

  def test_it_creates_invalid
    assert_not @subject.save
  end

  def test_it_adds_a_leader
    activity = activities(:traguitos)
    activity.users << users(:leader)

    assert activity.users.leader.any?
  end

  def test_it_adds_an_attender
    activity = activities(:traguitos)
    activity.users << users(:attender)

    assert activity.users.attender.any?
  end
end
