# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  description         :string
#  occurs_on           :string
#  occurs_frequency    :string
#  occurs_at           :date
#  start_at            :time
#  duration            :integer
#  active              :boolean          default(TRUE)
#  latitude            :decimal(, )
#  longitude           :decimal(, )
#  radius              :decimal(, )
#  organization_id     :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  validate_attendance :boolean          default(FALSE), not null
#


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
    user = users(:leader)

    activity.participants.create(activity: activity, user: user, roles: :leader)

    assert activity.users.exists?(user.id)
  end

  def test_it_adds_an_attender
    activity = activities(:traguitos)
    user = users(:attender)

    activity.participants.create(activity: activity, user: user, roles: :attender)

    assert activity.users.exists?(user.id)
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
