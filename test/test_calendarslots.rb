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
    event_type.duration_minutes = 10
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

    assert events.size.positive?
  end

  def test_opened_slots_with_bigger_event
    event_type = OpenStruct.new
    event_type.duration = OpenStruct.new
    event_type.duration_minutes = 10
    current_day = DateTime.tomorrow

    available_times = [
      {
        datetime_start: ::DateTime.tomorrow.noon,
        datetime_end: ::DateTime.tomorrow.noon + 1.hours
      }
    ]
    vevents_list = [
      OpenStruct.new(
        start: ::DateTime.tomorrow.noon + 10.minutes,
        end: ::DateTime.tomorrow.noon + 30.minutes,
      ),
    ]

    puts vevents_list

    events = Calendarslots.opened_slots_during(event_type, current_day, available_times, vevents_list)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end

  def test_opened_slots_with_smaller_event
    event_type = OpenStruct.new
    event_type.duration_minutes = 10
    current_day = DateTime.tomorrow

    available_times = [
      {
        datetime_start: ::DateTime.tomorrow.noon,
        datetime_end: ::DateTime.tomorrow.noon + 1.hours
      }
    ]
    vevents_list = [
      OpenStruct.new(
        start: ::DateTime.tomorrow.noon + 9.minutes,
        end: ::DateTime.tomorrow.noon + 12.minutes,
      ),
    ]

    puts vevents_list

    events = Calendarslots.opened_slots_during(event_type, current_day, available_times, vevents_list)

    assert events.size.positive?
  end

  def test_opened_slots_with_two_event
    event_type = OpenStruct.new
    event_type.duration_minutes = 10
    current_day = DateTime.tomorrow

    available_times = [
      {
        datetime_start: ::DateTime.tomorrow.noon,
        datetime_end: ::DateTime.tomorrow.noon + 1.hours
      }
    ]
    vevents_list = [
      OpenStruct.new(
        start: ::DateTime.tomorrow.noon + 9.minutes,
        end: ::DateTime.tomorrow.noon + 12.minutes,
      ),
      OpenStruct.new(
        start: ::DateTime.tomorrow.noon + 30.minutes,
        end: ::DateTime.tomorrow.noon + 35.minutes,
      ),
    ]

    puts vevents_list

    events = Calendarslots.opened_slots_during(event_type, current_day, available_times, vevents_list)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end
end
