# frozen_string_literal: true

# == Schema Information
#
# Table name: attendances
#
#  id          :bigint           not null, primary key
#  activity_id :bigint
#  user_id     :bigint
#  attended_at :datetime         not null
#  status      :string           default("pending"), not null
#  latitude    :decimal(, )
#  longitude   :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class AttendanceSerializer < ApplicationSerializer
  attributes :activity_id,
             :user_id,
             :attended_at,
             :status,
             :latitude,
             :longitude
end
