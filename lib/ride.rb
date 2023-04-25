class Ride
  attr_reader :name, :distance, :terrain, :is_loop

  def initialize(details)
    @name = details[:name]
    @distance = details[:distance]
    @is_loop = details[:loop]
    @terrain = details[:terrain]
  end

  def loop?
    @is_loop
  end

  def total_distance
    if loop? then return distance else return distance * 2 end
  end
end