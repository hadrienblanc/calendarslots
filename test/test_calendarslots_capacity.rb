require 'minitest/autorun'
require 'calendarslots'
require 'ostruct'

class CalendarslotsCapacityTest < Minitest::Test
  def test_opened_slots_with_free_one_on_two_capacity

    puts "[capacity start]"
    options = OpenStruct.new
    options.duration_minutes = 10
    options.time_optimization = true
    options.capacity = 2
  
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

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    puts "[capacity]"
    assert events.size.positive?
  end

  def test_opened_slots_with_full_two_capacity

    puts "[capacity start]"
    options = OpenStruct.new
    options.duration_minutes = 10
    options.time_optimization = true
    options.capacity = 2
  
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
        start: ::DateTime.tomorrow.noon + 9.minutes,
        end: ::DateTime.tomorrow.noon + 12.minutes,
      ),
      OpenStruct.new(
        start: ::DateTime.tomorrow.noon + 30.minutes,
        end: ::DateTime.tomorrow.noon + 35.minutes,
      ),
    ]

    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    puts "[capacity]"
    assert events.size.positive?
  end
end
