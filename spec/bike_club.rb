require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Thank Gravel It's Friday")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @biker3 = Biker.new("Bicycle Micycle", 100)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @ride3 = Ride.new({name: "Flagstaff", distance: 6.8, loop: false, terrain: :hills})
    @ride4 = Ride.new({name: "Switzerland Trail", distance: 43.6, loop: true, terrain: :gravel})

    @biker1.learn_terrain!(:gravel)
    @biker1.learn_terrain!(:hills)
    @biker2.learn_terrain!(:gravel)
    @biker2.learn_terrain!(:hills)
    @biker3.learn_terrain!(:gravel)
    @biker3.learn_terrain!(:hills)
  end

  describe "#initialize" do
    it "initializes" do
      expect(@club).to be_an(BikeClub)
    end

    it "initializes with attributes" do
      expect(@club.name).to eq("Thank Gravel It's Friday")
    end
  end

  describe "#add_biker" do
    it "starts with no bikers and can add them" do
      expect(@club.bikers).to eq([])

      @club.add_biker(@biker1)
      @club.add_biker(@biker2)

      expect(@club.bikers).to eq([@biker1, @biker2])
    end
  end

  describe "#most_rides" do
    it "can determine the rider with the most rides" do
      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride1, 91.1)
      @biker1.log_ride(@ride2, 60.9)

      @biker2.log_ride(@ride1, 92.5)
      @biker2.log_ride(@ride2, 61.1)

      @biker3.log_ride(@ride1, 73.5)
      @biker3.log_ride(@ride2, 40.3)
      @biker3.log_ride(@ride3, 120.9)
      @biker3.log_ride(@ride3, 131.6)

      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expect(@club.most_rides).to eq(@biker3)
    end
  end
end