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
