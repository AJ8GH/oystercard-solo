class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise MaxBalanceError if over_limit?(amount)
    self.balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise LowBalanceError if low_balance?
    self.entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    self.exit_station = station
    save_journey
    self.entry_station = nil
  end

  private

  attr_writer :balance, :entry_station, :exit_station

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def low_balance?
    balance < MINIMUM_FARE
  end

  def deduct(amount)
    self.balance -= amount
  end

  def save_journey
    journeys << {entry_station: entry_station, exit_station: exit_station}
  end
end
