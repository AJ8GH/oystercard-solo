class JourneyLog
  attr_reader :current_journey, :history

  def start(station = nil)
    self.current_journey = journey_class.new(entry_station: station)
  end

  def journeys
    history.dup
  end

  def finish(station = nil)
    current_journey.exit_station = station
    history << current_journey
    self.current_journey = nil
  end

  private

  attr_reader :journey_class
  attr_writer :current_journey

  def initialize(journey_class = Journey)
    @history = []
    @journey_class = journey_class
    @current_journey = nil
  end
end
