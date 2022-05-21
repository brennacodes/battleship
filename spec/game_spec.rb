require 'spec_helper'

RSpec.describe do
  let!(:board) {Board.new}
  let!(:makes_cells) {board.cells}
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}
  let!(:new_game) {Game.new}

  it "is an instance of" do
    expect(new_game).to be_instance_of Game
  end

  it "can start a game" do
    expect(new_game.start_game).to include("Welcome")
  end

  it "can tell a players fleet" do

  end

  it "can tell a ships name" do

  end

  it "can setup a game" do

  end
end
