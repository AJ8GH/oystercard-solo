class Station
  attr_reader :name, :zone

  def initialize(args = {})
    @name = args.fetch(:name)
    @zone = args.fetch(:zone)
  end
end
