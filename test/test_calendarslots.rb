require 'minitest/autorun'
require 'calendarslots'

class CalendarslotsTest < Minitest::Test
  def test_english_hello
    assert_equal 'Hello world!', Calendarslots.hi
  end
end
