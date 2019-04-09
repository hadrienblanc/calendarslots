module Calendarslots
  class VeventList
    def initialize(event_type, vevent_list_data)
      @vevent_list = vevent_list_data
      @vevent_cursor = 0
      @vevent_size = @vevent_list.size
      @event_type = event_type
    end

    def move_the_cursor_after(datetime)
      while still_has_vevents && vevent_at_cursor_is_in_the_past(datetime)
        @vevent_cursor += 1
      end
    end

    def still_has_vevents
      @vevent_cursor < @vevent_size
    end

    def vevent_at_cursor_is_in_the_past(datetime)
      vevent_at_cursor.end <= datetime
    end

    def vevent_at_cursor
      @vevent_list[@vevent_cursor]
    end

    def overlaps?(datetime)
      move_the_cursor_after(datetime)
      still_has_vevents && vevent_at_cursor_overlaps?(datetime)
    end

    def vevent_at_cursor_overlaps?(datetime)
      datetime < vevent_at_cursor.end && vevent_at_cursor.start < potential_vevent_end(datetime)
    end

    private

    def potential_vevent_end(datetime)
      (datetime + @event_type.duration.minutes)
    end
  end
end