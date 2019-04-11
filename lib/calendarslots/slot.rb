# frozen_string_literal: true

module Calendarslots
  class Slot
    attr_accessor :start
    attr_accessor :end
    attr_accessor :available
    attr_accessor :vevent

    include Comparable

    def initialize(datetime_start, datetime_end, available, vevent = nil)
      @start = datetime_start
      @end = datetime_end
      @available = available
      @vevent = vevent
    end

    def unavailable
      !@available
    end

    def <=>(other)
      start <=> other.start
    end

    def print_out
      "start: #{@start} end:#{@end} [available? : #{available}]"
    end
  end
end
