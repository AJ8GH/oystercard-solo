class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise MaxBalanceError if over_limit?(amount)
    self.balance += 1
  end

  private

  attr_writer :balance

  def over_limit?(amount)
    balance + amount > MAX_BALANCE
  end
end
