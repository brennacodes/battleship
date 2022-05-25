require './lib/helper'
# require './lib/ship'
# # require './lib/messages'

RSpec.describe do
  let!(:cell) {Cell.new("C4")}
  let!(:cell1) {Cell.new("B2")}
  let!(:cell2) {Cell.new("B3")}
  let!(:cell3) {Cell.new("B4")}
  let!(:cruiser) {Ship.new("Cruiser", 3)}

  it "is an instance of" do
    expect(cell).to be_instance_of Cell
  end

  it "has a coordinate" do
    expect(cell.coordinate).to eq("C4")
  end

  it "has a ship" do
    expect(cell.ship).to eq(nil)
  end

  it "can check if it's emptyor not" do
    expect(cell.empty?).to eq(true)
    cell.place_ship(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it "can place ships" do
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
  end

  it "can knows when it has been fired upon" do
    expect(cell.fired_upon?).to eq(false)
    cell.place_ship(cruiser)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
  end

  it "reduces ship health when fired upon" do
    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to eq(false)
    expect(cell.ship.health).to eq(3)
    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to eq(true)
  end

  it "can render a string element depending on state" do
    expect(cell.render).to eq("🌊")
    cell.fire_upon
    expect(cell.render).to eq("🐳")
    expect(cell.render(true)).to eq("🐳")
    cell1.place_ship(cruiser)
    cell2.place_ship(cruiser)
    cell3.place_ship(cruiser)
    expect(cell3.render).to eq("🌊")
    expect(cell3.render(true)).to eq("🚢")
    cell3.fire_upon
    expect(cell3.render(true)).to eq("💥")
    expect(cruiser.sunk?).to eq(false)
    cell2.fire_upon
    cell1.fire_upon
    expect(cruiser.sunk?).to eq(true)
    expect(cell1.render(true)).to eq("💀")
    expect(cell2.render(true)).to eq("💀")
    expect(cell3.render(true)).to eq("💀")
  end
end
