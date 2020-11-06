require 'oystercard'

describe Oystercard do

  let(:card_with_money) { Oystercard.new(20) }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station}

  describe "#initialize" do
    it "has a default balance of 0 when set up" do
      expect(subject.balance).to eq 0
    end

    it "is not in a journey by default" do
      expect(subject).not_to be_in_journey
    end

    it "has an empty list of journeys by default" do
      expect(subject.journeys).to be_empty
    end
  end

  describe "#top_up" do
    it "increases balance by 5 when topped up by 5" do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it "has a maximum balance constant set at 90" do
      expect(Oystercard::MAX_BALANCE).to eq(90)
    end

    it "raises an error if maximum balance is exceeded" do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error(StandardError)
    end
  end

  context "when touching in" do

    it "won't let a user touch in if they don't have enough money" do
      expect { subject.touch_in(entry_station) }.to raise_error(StandardError)
    end

    # it "is in journey if user touches in" do
    #   expect(card_with_money).to be_in_journey
    # end

    it "should remember entry station after touching in" do
      card_with_money.touch_in(entry_station)
      expect(card_with_money.journey.entry_station).to eq(entry_station)
    end

    it "charges penalty if you touch in without touching out" do
      card_with_money.touch_in(entry_station)
      expect{ card_with_money.touch_in(entry_station)}.to change {card_with_money.balance}.by(-6)
    end

  end

  context "when journeys are complete" do

    it "should deduct £1 after touching out" do
      card_with_money.touch_in(entry_station)
      expect { card_with_money.touch_out(exit_station) }.to change { card_with_money.balance }.by(-Oystercard::MIN_JOURNEY_AMOUNT)
    end

    before do
      card_with_money.touch_in(entry_station)
      card_with_money.touch_out(exit_station)
    end

    it "ends journey after touching out" do
      expect(card_with_money).not_to be_in_journey
    end

    it "stores a journey" do
      expect(card_with_money.journeys[0]).to be_instance_of Journey
    end
  end

end
