# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  roles_mask             :integer
#  organization_id        :bigint
#  full_name              :string
#


require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @subject = User.new
  end

  def test_it_creates_valid
    @subject.email = "example_user@checkinar.io"
    @subject.full_name = "Erick Torrez"
    @subject.password = "example$password"
    @subject.roles << :normal
    @subject.organization = organizations(:michelada)

    assert @subject.save
  end

  def test_it_wont_createdsinvalid
    assert_not @subject.save
  end

  def test_it_is_not_valid_without_an_email
    @subject.full_name = "Annabel Robles"
    @subject.password = "example$password"
    @subject.roles << :normal
    @subject.organization = organizations(:michelada)

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_without_a_name
    @subject.password = "example$password"
    @subject.organization = organizations(:michelada)
    @subject.roles << :normal
    @subject.organization = organizations(:michelada)

    assert_not @subject.valid?
  end

  def test_it_is_not_valid_with_no_organization_relation
    @subject.email = "example_user@checkinar.io"
    @subject.full_name = "Diego Zaizar"
    @subject.password = "example$password"
    @subject.roles << :normal

    assert_not @subject.valid?
  end
end
