class Oystercard
  MINIMUM_FARE = 1
  MAX_BALANCE = 90

  attr_reader :balance, :journeys

  def top_up(amount)
    raise MaxBalanceError if over_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    raise LowBalanceError if balance < MINIMUM_FARE
    unexpected_touch_in
    journey_log.start(station)
  end

  def touch_out(station)
    fail if unexpected_touch_out(station)
    journey_log.finish(station)
    deduct
  end

  def journeys
    journey_log.history.dup
  end

  private

  attr_writer :balance
  attr_reader :journey_class
  attr_accessor :journey_log

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
    @journey_class = journey_class
  end

  def unexpected_touch_in
    if journey_log.current_journey
      journey_log.finish
      deduct
    end
  end

  def unexpected_touch_out(station)
    unless journey_log.current_journey
      journey_log.start
      journey_log.finish(station)
      deduct
    end
  end

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct
    self.balance -= journey_log.history.last.fare
  end
end
