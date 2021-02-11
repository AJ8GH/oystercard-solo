class MaxBalanceError < Exception
  attr_reader :msg

  def initialize
    @msg = "Maximum balance is #{Oystercard::MAX_BALANCE}"
  end
end

class LowBalanceError < Exception
  attr_reader :msg

  def initialize
    @msg = "Minimum fare is #{Oystercard::MINIMUM_FARE}"
  end
end
