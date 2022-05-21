require './lib2/ship'
require './lib2/cell'

RSpec.describe do
  let!(:cell) {Cell.new("B4")}
  let!(:cell_2) {Cell.new("C3")}
  let!(:cruiser) {Ship.new("Cruiser", 3)}

  it "is an instance of" do
    expect(cell).to be_instance_of Cell
  end

  it "has a coordinate" do
    expect(cell.coordinate).to eq("B4")
  end

  it "has a ship" do
    expect(cell.ship).to eq(nil)
  end

  it "can see ships" do
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
  end

  it 'is empty unless a ship is there' do
    expect(cell.empty?).to eq(true)
    cell.place_ship(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it "can be fired upon" do
    expect(cell.fired_upon?).to eq(false)
    cell.place_ship(cruiser)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
  end

  it "can change ship health" do
    cell.place_ship(cruiser)
    cell.fire_upon
    expect(cell.ship.health).to eq(2)
  end

  it "can render a string element depending on state" do
    cell.render
    expect(cell.render).to eq(".")
    # cell.fire_upon
    # expect(cell.render(true)).to eq("M")
    cell_2.place_ship(cruiser)
    cell_2.render
    expect(cell_2.render).to eq(".")
    cell_2.render(true)
    expect(cell_2.render(true)).to eq("S")
    cell_2.fire_upon
    expect(cell_2.render).to eq("H")
  end

  it "can see if a ship sinks and changes the render" do
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    expect(cruiser.sunk?).to eq(false)
    cruiser.hit
    cruiser.hit
    expect(cruiser.sunk?).to eq(true)
    expect(cell_2.render).to eq("X")
  end
end
