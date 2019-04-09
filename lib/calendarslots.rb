# frozen_string_literal: true
require 'date'

require 'calendarslots/slot'
require 'calendarslots/vevent_list'
require 'calendarslots/constraint'
require 'active_support/time'

##
# This module is the main module of the gem
#
module Calendarslots
  def self.hello
    'Hello world!'
  end

  def self.opened_slots_during(event_type, current_day, available_times, taken_slots_data_list)
    if available_times.nil? || available_times.empty? || current_day.past?
      return []
    end

    constraint = Constraint.new(current_day.beginning_of_day..current_day.end_of_day, event_type, taken_slots_data_list)

    day_slots = []
    available_times.each do |available_time|
      current_day = available_time[:datetime_start]
      a_end = available_time[:datetime_end]
      puts "current_day : #{current_day}"
      puts "a_end : #{a_end}"
      while current_day < a_end
        slot = constraint.generate_slot(current_day)
        day_slots << slot
        current_day = slot.end
        # à la suite : rendez-vous glissant. (on prends la première disponibilité possible, a la fin de l'indispo)
        # todo : a mettre dans Constraint pour ne pas partager le vevent courrant de l'algo.
        # todo 2 : optionnel
        # current_day = slot.vevent.end if slot.vevent && !slot.available # 
      end
    end
    day_slots
  end


end
