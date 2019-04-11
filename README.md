# Calendarslots
Find your available slots in your calendar.

Put your Ruby code in the file `lib/calendarslots`. 
To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'calendarslots'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calendarslots

## Usage

### Options 

- duration_minutes : duration of the slot for the wanted meeting
- capacity : the number of meeting potentially taken in the availability
- offset_end : time before a meeting 
- offset_start : time after a meeting

### roadmap options
- weight of a meeting in the capacity (every meeting is currently one)

## Development Install

`bundle install`

## License

The gem is available with a commercial license.
