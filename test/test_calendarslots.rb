require 'minitest/autorun'
require 'calendarslots'
require 'ostruct'


class CalendarslotsTest < Minitest::Test
  def test_english_hello
    assert_equal 'Hello world!', Calendarslots.hello
  end

  def test_opened_slots_empty_parameters
    event_type = nil
    current_day = nil
    available_times = nil
    taken_slots_data_list = nil

    assert_equal [], Calendarslots.opened_slots_during(event_type, current_day, available_times, taken_slots_data_list)
  end

  def test_opened_slots_one
    event_type = OpenStruct.new
    event_type.duration = OpenStruct.new
    event_type.duration.minutes = 60 * 10
    current_day = DateTime.tomorrow

    available_times = [
      {
        datetime_start: ::DateTime.tomorrow.noon,
        datetime_end: ::DateTime.tomorrow.noon + 1.hours
      }
    ]
    taken_slots_data_list = []

    events = Calendarslots.opened_slots_during(event_type, current_day, available_times, taken_slots_data_list)

    events.each do |ev|
      puts ev.print_out
    end

#    assert_equal 

  end
end
