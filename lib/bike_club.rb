class BikeClub
  attr_reader :name, :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    ride_log = Hash.new(0)
    @bikers.each do |biker|
      count = biker.rides.map { |ride, values| values.count}.sum
      ride_log[biker] = count
    end
    ride_log.max_by { |rider, rides| ride_log[rider] }.first
  end
end