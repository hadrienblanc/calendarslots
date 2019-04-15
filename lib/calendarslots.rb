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

  #
  # option : duration_minutes 
  def self.opened_slots_during(available_times, taken_slots_data_list, options)
    if available_times.nil? || available_times.empty? # || current_day.past?
      return []
    end

    options.offset_end = 0 if options.offset_end.nil? 
    options.offset_start = 0 if options.offset_start.nil? 

    constraint = Constraint.new(options, taken_slots_data_list)

    day_slots = []
    available_times.each do |available_time|
      current_day = available_time[:datetime_start]
      puts "- current_day : #{current_day}"
      puts "- a_end : #{available_time[:datetime_end]}"
      while current_day < available_time[:datetime_end]
        slot = constraint.generate_slot(current_day)
        day_slots << slot if (slot.end + constraint.offset_end) <= available_time[:datetime_end]
        current_day = (slot.end + constraint.offset_end)

#        if options.time_optimization && slot.vevent
 #         current_day = slot.vevent.end
 #       else
  #        current_day = slot.end
   #     end
        # à la suite : rendez-vous glissant. (on prends la première disponibilité possible, a la fin de l'indispo)
        # todo : a mettre dans Constraint pour ne pas partager le vevent courrant de l'algo.
        # todo 2 : optionnel
#        current_day = slot.vevent.end if options.time_optimization && slot.vevent && !slot.available && slot.vevent.end < current_day  
        # | en cas de plusieurs vevents il faudra prendre le dernier moment où il y a 
        # le maximum de vevent. (comme à tel moment)
      end
    end
    day_slots
  end


end
