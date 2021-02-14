class Journey
  PENALTY_FARE = 6

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
    return PENALTY_FARE unless complete?
    Oystercard::MINIMUM_FARE + (entry_station.zone - exit_station.zone).abs
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
