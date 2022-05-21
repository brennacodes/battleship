require './lib/ship'

RSpec.describe do
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}

  it "is an instance of Ship" do
    expect(cruiser).to be_instance_of Ship
  end

  it "has a length" do
    expect(cruiser.length).to eq(3)
    expect(submarine.length).to eq(2)
  end

  it "has a type" do
    expect(cruiser.type).to eq("Cruiser")
    expect(submarine.type).to eq("Submarine")
  end


  it "can track its health" do
    expect(cruiser.health).to eq(3)
    expect(submarine.health).to eq(2)
  end

  it "take hits" do
    cruiser.hit
    expect(cruiser.health).to eq(2)
    submarine.hit
    expect(submarine.health).to eq(1)
  end

  it "can report if sunk or not" do
    cruiser.hit
    cruiser.hit
    cruiser.hit
    expect(cruiser.sunk?).to eq(true)
    submarine.hit
    expect(submarine.sunk?).to eq(false)
  end
end
