require_relative 'fares'

class Oystercard
  include Fares

  attr_reader :balance, :journeys

  MAX_BALANCE = 90

  def top_up(amount)
    raise MaxBalanceError if over_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    raise LowBalanceError if balance < MINIMUM_FARE
    new_journey(:entry_station, station)
    self.in_journey = true
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    in_journey? ? journeys.last.exit_station = station :
    new_journey(:exit_station, station)
    self.in_journey = false
  end

  private

  attr_writer :balance
  attr_reader :journey_class
  attr_accessor :in_journey

  def initialize(journey_class = Journey)
    @balance = 0
    @journeys = []
    @journey_class = journey_class
    @in_journey = false
  end

  def in_journey?
    in_journey
  end

  def new_journey(station_type, station)
    journeys << journey_class.new(station_type => station)
  end

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end
end
