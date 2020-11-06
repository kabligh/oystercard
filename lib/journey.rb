class Journey

  PENALTY_FARE = 6
  MIN_JOURNEY_AMOUNT = 1

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station
  end

  def complete?
    @entry_station != nil && @exit_station != nil
  end

  def fare
    !complete? ? PENALTY_FARE : MIN_JOURNEY_AMOUNT
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

end
