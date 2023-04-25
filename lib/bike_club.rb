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

  def best_time(ride)
    fastest_times = Hash.new(0)
    @bikers.each do |biker|
      time = biker.personal_record(ride)
      if time == false 
        time = 1000000
      end
      fastest_times[biker] = time
    end

    fastest_times.min_by { |rider, time| fastest_times[rider] }.first
  end
end