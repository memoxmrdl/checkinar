# frozen_string_literal: true

require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  def setup
    @subject = Activity.new
  end

  def test_it_creates_valid
    @subject.name = "Gym"
    @subject.occurs_on = Activity.occurs_ons[:date]
    @subject.occurs_at = Time.zone.now.to_date
    @subject.start_at = Time.zone.now
    @subject.duration = 60
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

  def test_it_valids_its_fields_occurs_on_date
    @subject.name = "Gym"
    @subject.occurs_on = Activity.occurs_ons[:date]

    @subject.valid?

    assert [:occurs_at, :start_at, :duration].any? { |field| @subject.errors.include? field }
  end

  def test_it_valids_its_fields_occurs_on_more_than_once
    @subject.name = "Gym"
    @subject.occurs_on = Activity.occurs_ons[:more_than_once]

    @subject.valid?

    assert [:occurs_frequency, :start_at, :duration].any? { |field| @subject.errors.include? field }
  end
end
