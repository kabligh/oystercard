require_relative 'journey'

class Oystercard

  attr_reader :balance, :journeys, :journey

  MAX_BALANCE = 90
  MIN_JOURNEY_AMOUNT = 1

  def initialize(balance = 0)
    @balance = balance
    @journey
    @journeys = []
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE} " if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    return false if @journey == nil
    !@journey.complete?
  end

  def touch_in(entry_station)
    raise StandardError.new "You need at least £#{MIN_JOURNEY_AMOUNT} to touch in" if @balance < MIN_JOURNEY_AMOUNT
    charge_and_reset if in_journey?
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @journey = Journey.new if !in_journey?
    @journey.finish(exit_station)
    charge_and_reset
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def charge_and_reset
    deduct(@journey.fare)
    @journeys << @journey
    @journey = nil
    @balance 
  end

end
