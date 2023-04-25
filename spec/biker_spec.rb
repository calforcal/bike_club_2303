require "./lib/ride"
require "./lib/biker"

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker2 = Biker.new("Athena", 15)
  end

  describe "#initialize" do
    it "initializes" do
      expect(@biker).to be_an(Biker)
    end

    it "can initialize with attributes" do
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
    end
  end

  describe "#acceptable_terrain && #learn_terrain" do
    it "can start with no terrain and learn to ride terrains" do
      expect(@biker.acceptable_terrain).to eq([])
      
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)

      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe "#rides && #log_ride" do
    it "can log rides and keep track of rides" do
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.rides).to eq({@ride1 => [92.5, 91.1]})
      expect(@biker.rides).to eq({@ride2 => [60.9, 61.6]})
    end
    
    it "won't log a ride if the rider doesn't know the ride terrain" do
      @biker2 = biker2.log_ride(@ride1, 97.0)
      @biker2.log_ride(@ride2, 67.0)

      expect(@biker2.rides).to eq({})

      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
    end

    it "won't log a ride if the ride if the rider can't ride the distance" do
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)

      @biker2 = biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)

      expect(@biker2.rides).to eq({@ride2 => [65.0]})
    end
  end

  describe "#personal_record" do
    it "can return the personal record for a given ride" do
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)
    end

    it "returns false if the rider hasn't ridden that ride" do
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)

      @biker2 = biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(ride2, 65.0)

      expect(@biker2.personal_record(@ride1)).to be(false)
      expect(@biker2.personal_record(@ride2)).to eq(65.0)
    end
  end
end