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
    finish_current_journey if current_journey
    self.current_journey = journey_class.start_journey(station)
  end

  def touch_out(station)
    journeys << current_journey.end_journey(station) if current_journey
    unexpected_touch_out(station) unless current_journey
    self.current_journey = nil
    deduct
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

  def unexpected_touch_out(station)
    journeys << journey_class.new_incomplete(station)
    self.current_journey = nil
  end

  def finish_current_journey
    journeys << current_journey
    deduct
  end

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct
    self.balance -= journeys.last.fare
  end
end
