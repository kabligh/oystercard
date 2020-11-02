class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90

  MIN_JOURNEY_AMOUNT = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE} " if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise StandardError.new "You need at least £#{MIN_JOURNEY_AMOUNT} to touch in" if @balance < MIN_JOURNEY_AMOUNT
    @in_journey = true
  end

  def touch_out
    deduct(1)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
