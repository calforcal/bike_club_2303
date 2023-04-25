class Biker
  attr_reader :name, :max_distance, :acceptable_terrain, :rides

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @acceptable_terrain = []
    @rides = Hash.new(0)
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    if can_ride?(ride)
      if @rides.has_key?(ride)
        @rides[ride] << time
      else
        @rides[ride] = [time]
      end
    else
      false
    end
  end

  def can_ride?(ride)
    if @acceptable_terrain.include?(ride.terrain) && @max_distance > ride.total_distance
      true
    else
      false
    end
  end

  def personal_record(ride)
    if can_ride?(ride)
      record = @rides[ride].min_by { |time| time }
      if record == 0 || record == nil then return false else return record end
    else
      false
    end
  end
end