require 'journey'
require 'oystercard'

describe Journey do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it "has a penalty fare by default" do
    expect(subject.fare).to eq(Journey::PENALTY_FARE)
  end

  it "returns the exit station when the journey is finished" do
    expect(subject.finish(exit_station)).to eq(exit_station)
  end

  context "when given an entry station" do
    let(:journey) { Journey.new(entry_station) }

    it "has an entry station" do
      expect(journey.entry_station).to eq entry_station
    end

    it "returns a penalty fare if no exit station given" do
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end

    context "when given an exit station" do

      before do
        journey.finish(exit_station)
      end

      it "calculates a fare" do
        expect(journey.fare).to eq(Journey::MIN_JOURNEY_AMOUNT)
      end

    end

  end


end
