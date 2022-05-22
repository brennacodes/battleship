require 'spec_helper'

RSpec.describe do
  # let!(:board) {Board.new}
  # let!(:makes_cells) {board.cells}
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}
  # let!(:new_game) {GameRunner.new(player1)}


  it "is an instance of" do
    expect(player1).to be_instance_of Player
    expect(computer).to be_instance_of Player
  end

  it "can make a fleet" do
    player1.make_ship("Cruiser", 3)
    player1.make_ship("Sub", 2)

    expect(player1.fleet.length).to eq(2)
  end

  it "can track fleet health" do
    player1.make_ship("Cruiser", 3)
    player1.make_ship("Sub", 2)

    expect(player1.fleet_health).to eq(5)
  end

  it "can track fleet health after shots fired" do
    board
    makes_cells
    new_game
    computer.make_ship("Cruiser", 3)
    computer.make_ship("Sub", 2)
    computer.board.place("Cruiser", ['A1', 'A2', 'A3'])
    require "pry"; binding.pry
    player1.make_ship("Cruiser", 3)
    player1.make_ship("Sub", 2)
    player1.take_shot('A1')
    expect(computer.fleet_health).to eq(4)
  end
end
