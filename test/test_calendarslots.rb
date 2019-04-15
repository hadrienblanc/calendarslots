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

    assert_equal [], Calendarslots.opened_slots_during(available_times, taken_slots_data_list, nil)
  end

  def test_opened_slots_one
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0
    options.duration_minutes = 10
    options.time_optimization = false
    current_day = DateTime.tomorrow

    available_times = [
      {
        datetime_start: ::DateTime.tomorrow.noon,
        datetime_end: ::DateTime.tomorrow.noon + 1.hours
      }
    ]
    vevents_list = []

    puts "no events"
    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    events.each do |ev|
      puts ev.print_out
    end

    assert events.size.positive?
  end

  def test_opened_slots_with_bigger_event
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0
    options.duration_minutes = 10
    options.time_optimization = false

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


    puts "events list : "
    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end

  def test_opened_slots_with_smaller_event
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0
    options.duration_minutes = 10
    options.time_optimization = false

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
    puts "events list : "
    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    assert events.size.positive?
  end

  def test_opened_slots_with_two_event
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0

    options.duration_minutes = 10
    options.time_optimization = true

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

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end

  def test_opened_slots_random_data
    puts "[random test]"
    puts "[random test]"
    puts "[random test]"
    
    options = OpenStruct.new
    options.offset_end = 0
    options.offset_start = 0

    options.duration_minutes = 10
    options.time_optimization = true

    current_day = DateTime.tomorrow

    available_times = [
      {
        datetime_start: ::DateTime.tomorrow.noon,
        datetime_end: ::DateTime.tomorrow.noon + 1.hours
      }
    ]

    vevents_list = []
    i_vevents = rand(10) + 2
    timeline = 0
    event_duration = 0
    i = 0
    while i < i_vevents
      event_duration = rand(30) + 1
      event_space = rand(30) + 1
      vevents_list << OpenStruct.new(
        start: ::DateTime.tomorrow.noon + (event_space + timeline).minutes,
        end: ::DateTime.tomorrow.noon + (event_space + timeline + event_duration).minutes,
      )
      timeline += event_duration + event_space

      i += 1
    end
  
    puts vevents_list

    events = Calendarslots.opened_slots_during(available_times, vevents_list, options)

    events.each do |ev|
      puts ev.print_out
    end
    puts "--" * 10
    assert events.size.positive?
  end
end
