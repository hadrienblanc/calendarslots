# frozen_string_literal: true

module Calendarslots
  class Constraint
    def initialize(options, vevent_list_data = [])
      @options = options
      @vevent_list = VeventList.new(options, vevent_list_data)
    end

    def generate_slot(datetime)
      Slot.new(datetime + offset_start,
               datetime + offset_start + @options.duration_minutes.minutes + offset_end,
               slot_is_available?(datetime),
               @vevent_list.vevent_at_cursor)
    end

    def slot_is_available?(datetime)
      datetime.future? \
        && we_have_space_at_this_time(datetime)
    end

    def we_have_space_at_this_time(datetime)
      @vevent_list.space_at?(datetime)
    end

    def offset_start
      return 0 unless @options.offset_start

      @options.offset_start.minutes
    end

    def offset_end
      return 0 unless @options.offset_end

      @options.offset_end.minutes
    end
  end
end