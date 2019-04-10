module Calendarslots
  class VeventList
    def initialize(options, vevent_list_data)
      @vevent_list = vevent_list_data
      @vevent_cursor = 0
      @vevent_size = @vevent_list.size
      @options = options
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

    def space_at?(datetime)
      return true if !still_has_vevents

      move_the_cursor_after(datetime)
      space_at_with_capacity?(datetime)
    end

    def space_at_with_capacity(datetime)
      if @options.capacity
        # on compte les overlaps sur les prochains de la liste,
        # et si c'est < capacity, ya de la place
      else
        !vevent_at_cursor_overlaps?(datetime)
      end
    end

    def vevent_at_cursor_overlaps?(datetime)
      datetime < vevent_at_cursor.end && vevent_at_cursor.start < potential_vevent_end(datetime)
    end

    private

    def potential_vevent_end(datetime)
      (datetime + @options.duration_minutes.minutes)
    end
  end
end