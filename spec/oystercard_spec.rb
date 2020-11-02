require 'oystercard'

describe Oystercard do

  let(:card_with_money) { Oystercard.new(1) }
  let(:station) { double :station }

  it "has a default balance of 0 when set up" do
    expect(subject.balance).to eq 0
  end

  it "balance increases by 5 when topped up by 5" do
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

  it "is not in a journey by default" do
    expect(subject.in_journey?).to eq false
  end

  it "is in journey if user touches in" do
    card_with_money.touch_in(station)
    expect(card_with_money.in_journey?).to eq true
  end

  it "ends journey after touching out" do
    card_with_money.touch_in(station)
    card_with_money.touch_out
    expect(subject.in_journey?).to eq false
  end

  it "won't let a user touch in if they don't have enough money" do
    expect { subject.touch_in(station) }.to raise_error(StandardError)
  end

  it "should deduct £1 after touching out" do
    expect { card_with_money.touch_out }.to change { card_with_money.balance }.by(-1)
  end

  it "should remember entry station after touching in" do
    card_with_money.touch_in(station)
    expect(card_with_money.entry_station).to eq(station)
  end

end
