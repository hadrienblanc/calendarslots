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

    def still_has_vevents(offset = 0)
      @vevent_cursor + offset < @vevent_size
    end

    def vevent_at_cursor_is_in_the_past(datetime)
      vevent_at_cursor.end + @options.offset_end <= datetime
    end

    def vevent_at_cursor()
      @vevent_list[@vevent_cursor]
    end

    def vevent_at_cursor_offset(offset)
      return nil if (@vevent_cursor + offset) > @vevent_size

      @vevent_list[@vevent_cursor + offset]
    end

    def overlaps?(datetime)
      move_the_cursor_after(datetime)
      still_has_vevents && vevent_at_cursor_overlaps?(datetime)
    end

    def space_at?(datetime)
      return true if !still_has_vevents

      move_the_cursor_after(datetime)
      !still_has_vevents || space_at_with_capacity?(datetime)
    end

    def space_at_with_capacity?(datetime)
      puts "space_at_with_capacity MAN"
      if @options.capacity
        offset = 0
        overlap_count = 0
        while offset < @options.capacity
          if !still_has_vevents(offset) || !vevent_at_cursor_offset_overlaps?(datetime, offset)
            return true
          end
          offset += 1
        end
        return false
      else
        !vevent_at_cursor_overlaps?(datetime)
      end
    end

    def vevent_at_cursor_offset_overlaps?(datetime, offset)
      datetime < vevent_at_cursor_offset(offset).end + @options.offset_end \
      && vevent_at_cursor_offset(offset).start < potential_vevent_end(datetime)
    end

    def vevent_at_cursor_overlaps?(datetime)
      datetime < (vevent_at_cursor.end + @options.offset_end) \
        && vevent_at_cursor.start < potential_vevent_end(datetime)
    end

    private

    def potential_vevent_end(datetime)
      (datetime + @options.offset_start + @options.duration_minutes.minutes + @options.offset_end)
    end
  end
end