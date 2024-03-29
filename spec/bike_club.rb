require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Thank Gravel It's Friday")
    @club2 = BikeClub.new("Rapha")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @biker3 = Biker.new("Bicycle Micycle", 100)
    @biker4 = Biker.new("Cris", 40)
    @biker5 = Biker.new("Arthur", 60)
    @biker6 = Biker.new("Zoe", 100)
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
    @biker4.learn_terrain!(:gravel)
    @biker4.learn_terrain!(:hills)
    @biker5.learn_terrain!(:gravel)
    @biker5.learn_terrain!(:hills)
    @biker6.learn_terrain!(:gravel)
    @biker6.learn_terrain!(:hills)
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

  describe "#best_time" do
    it "can return the biker with the best time on a given ride" do
      @biker1.log_ride(@ride1, 72.5)
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

      expect(@club.best_time(@ride1)).to eq(@biker1)
    end
  end

  describe "#bikers_eligible(ride)" do
    it "can determine which riders are eligble for a certain ride" do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expect(@club.bikers_eligible(@ride1)).to eq([@biker1, @biker3])
    end
  end

  describe "#record_group_ride(ride) && #group_rides" do
    it "can return a hash with group ride details" do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      allow(Time).to receive(:now).and_return("12:00.00")
      expected = {
        start_time: "12:00.00",
        ride: @ride1,
        members: [@biker1, @biker3]
      }

      expect(@club.record_group_ride(@ride1)).to eq(expected)
    end

    it "can return the recorded group rides" do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expected = {
        start_time: "12:00.00",
        ride: @ride1,
        members: [@biker1, @biker3]
      }

      allow(Time).to receive(:now).and_return("12:00.00")
      @club.record_group_ride(@ride1)

      expect(@club.group_rides).to eq([expected])
    end
  end

  describe "#self.best_rider" do
    it "can return the best_rider for a given ride across all BikeClub instances" do
      BikeClub.clear
      @club = BikeClub.new("Thank Gravel It's Friday")
      @club2 = BikeClub.new("Rapha")
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)
      @club2.add_biker(@biker4)
      @club2.add_biker(@biker5)
      @club2.add_biker(@biker6)

      @biker1.log_ride(@ride1, 92.5)
      @biker2.log_ride(@ride1, 78.9)
      @biker3.log_ride(@ride1, 84.2)
      @biker4.log_ride(@ride1, 82.5)
      @biker5.log_ride(@ride1, 98.5)
      @biker6.log_ride(@ride1, 68.5)

      expect(BikeClub.best_rider(@ride1)).to eq(@biker6)
    end
  end
end