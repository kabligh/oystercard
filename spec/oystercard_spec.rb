require 'oystercard'

describe Oystercard do

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

  it "deducts fares from cards" do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

end
