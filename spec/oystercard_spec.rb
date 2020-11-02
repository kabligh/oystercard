require 'oystercard'

describe Oystercard do

  it "has a default balance of 0 when set up" do
    expect(subject.balance).to eq 0
  end

  it "can be topped up with money" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "balance increases by 5 when topped up by 5" do
    expect { subject.top_up(5) }.to change { subject.balance }.by(5)
  end

  it "has a maximum balance constant set at 90" do
    expect(Oystercard::MAX_BALANCE).to eq(90)
  end 

  it "Should raise an error message if topped up above maximum balance of 90" do
    expect { subject.top_up(91) }.to raise_error(StandardError)
  end

end
