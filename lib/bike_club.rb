class BikeClub
  attr_reader :name, :bikers, :group_rides

  @@instances = []

  def initialize(name)
    @name = name
    @bikers = []
    @group_rides = []
    @@instances << self
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

  def bikers_eligible(ride)
    @bikers.select { |biker| biker.can_ride?(ride)}
  end

  def record_group_ride(ride)
    ride = {
      start_time: Time.now,
      ride: ride,
      members: bikers_eligible(ride)
    }

    @group_rides << ride
    ride
  end

  def self.all
    @@instances
  end

  def self.clear
    @@instances.clear
  end

  def self.best_rider(ride)
    best_times = all.map { |club| club.best_time(ride) }
    best_times.min_by { |biker| biker.personal_record(ride) }
  end
end