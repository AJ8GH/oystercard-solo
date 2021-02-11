class MaxBalanceError < Exception
  attr_reader :msg

  def initialize
    @msg = "Maximum balance is #{Oystercard::MAX_BALANCE}"
  end
end
