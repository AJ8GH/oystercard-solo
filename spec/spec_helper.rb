require 'simplecov'
require 'simplecov-console'

require 'oystercard_challenge'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start
