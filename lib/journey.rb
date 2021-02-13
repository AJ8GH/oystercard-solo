require_relative 'fares'

class Journey
  include Fares

  attr_reader :entry_station
  attr_accessor :exit_station

  def initialize(args = {})
    @entry_station = args[:entry_station]
    @exit_station = args[:exit_station]
  end

  def complete?
    entry_station && exit_station
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def end_journey(station = nil)
    self.exit_station = station
    self
  end

  def self.start_journey(station)
    self.new(entry_station: station)
  end

  def self.new_incomplete(station)
    self.new(exit_station: station)
  end
end
