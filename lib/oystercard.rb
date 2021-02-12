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
    start_journey(station)
  end

  def touch_out(station)
    unexpected_touch_out(station) unless current_journey
    journeys.last.exit_station = station if current_journey
    deduct(MINIMUM_FARE)
  end

  private

  attr_writer :balance
  attr_reader :journey_class
  attr_accessor :current_journey

  def initialize(journey_class = Journey)
    @balance = 0
    @journeys = []
    @journey_class = journey_class
    @current_journey = nil
  end

  def start_journey(station)
    journeys << current_journey = journey_class.new(entry_station: station)
  end

  def unexpected_touch_out(station)
    journeys << journey_class.new(exit_station: station)
  end

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end
end
