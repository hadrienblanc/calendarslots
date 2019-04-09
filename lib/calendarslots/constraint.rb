module Calendarslots
  class Constraint
    def initialize(date_range, event_type, vevent_list_data = [], calendar_config = nil)
      @date_range = date_range
      @event_type = event_type
      @vevent_list = VeventList.new(event_type, vevent_list_data)
    end

    def generate_slot(datetime)
      Slot.new(datetime,
               datetime + @event_type.duration_minutes.minutes,
               slot_is_available?(datetime),
               @vevent_list.vevent_at_cursor)
    end

    def slot_is_available?(datetime)
      datetime.future? \
        && !we_have_an_event_at_this_time(datetime) #\
        #&& booking_range?(datetime)
    end

    def we_have_an_event_at_this_time(datetime)
      @vevent_list.overlaps?(datetime)
    end

    def booking_range?(datetime) # if we still are ok to book (exemple : only 15 days ) hour_to_book_before..until_when_people_can_book
      (@event_type.booking_range).cover?(datetime)
    end
  end
end