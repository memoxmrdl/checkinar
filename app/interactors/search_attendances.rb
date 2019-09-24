# frozen_string_literal: true

class SearchAttendances
  include Interactor

  def call
    search_attendances
  end

  private
    def search_attendances
      date_range = context.attributes[:date_range]
      date_range = date_range.to_s.split(" - ")

      context.attendances = if date_range.size == 2
        date_range = date_range.map(&:to_date)
        context.activity.attendances.having_attended_at_between(*date_range)
      else
        context.activity.attendances
      end
    end
end
