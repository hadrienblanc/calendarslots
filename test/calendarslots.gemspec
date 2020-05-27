Gem::Specification.new do |spec|
  spec.name        = 'calendarslots'
  spec.version     = '0.0.2'
  spec.date        = '2019-04-01'
  spec.authors     = ['Hadrien Blanc']
  spec.email       = 'blanc.hadrien@gmail.com'

  spec.summary     = 'Find the open slots in your calendar'
  spec.description = 'Find the open slots in your calendar, considering your configuration'

  spec.files       = [
    'lib/calendarslotspec.rb',
    'lib/calendarslots/slot.rb']
  spec.homepage    = 'http://rubygemspec.org/gems/'
  spec.license     = 'Nonstandard'
  spec.add_dependency('activesupport', '>= 5.0.0.1', '< 7')

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
