require 'minitest/autorun'
require 'calendarslots'
require 'ostruct'

class CalendarslotsOffsetTest < Minitest::Test
  def test_opened_slots_with_offset_start
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0

    options.duration_minutes = 10
    options.time_optimization = false
    options.offset_start = 5

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
    puts "OFFSET start -- events list : "
    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)


    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end


  def test_opened_slots_with_offset_end
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0

    options.duration_minutes = 20
    options.time_optimization = false
    options.offset_end = 5

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
    puts "OFFSET END -- events list : "
    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)


    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end


  def test_opened_slots_with_offset_end_and_start
    options = OpenStruct.new
    options.duration_minutes = 10
    options.time_optimization = false
    options.offset_start = 5
    options.offset_end = 3

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
    puts "OFFSET START 4 AND END 3 -- events list : "
    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)


    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end

end
