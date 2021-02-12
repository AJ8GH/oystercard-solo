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
end
