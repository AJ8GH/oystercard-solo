require 'simplecov'
require 'simplecov-console'

require 'oystercard'
require 'exceptions'
require 'station'
require 'journey'
require 'fares'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start
