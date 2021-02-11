class Oystercard
  attr_reader :balance, :in_journey

  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise MaxBalanceError if over_limit?(amount)
    self.balance += amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    raise LowBalanceError if low_balance?
    self.in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    self.in_journey = false
  end

  private

  attr_writer :balance, :in_journey

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def low_balance?
    balance < MINIMUM_FARE
  end

  def deduct(amount)
    self.balance -= amount
  end
end
