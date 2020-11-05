class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAX_BALANCE = 90

  MIN_JOURNEY_AMOUNT = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE} " if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station ? true : false
  end

  def touch_in(entry_station)
    raise StandardError.new "You need at least £#{MIN_JOURNEY_AMOUNT} to touch in" if @balance < MIN_JOURNEY_AMOUNT
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    save_journey
    deduct(MIN_JOURNEY_AMOUNT)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
  end

end
