require 'spec_helper'

RSpec.describe Game do
  let!(:game) {Game.new}

  it "literally can't run a single test" do
    expect(angry_terminal_output).to be Ugly
  end

  it "makes me cry" do
    expect(river_of_tears).to be Watery
  end

  it "is an instance of" do
    expect(game).to be_instance_of Game
  end

  # it "can tell a players fleet" do
  #   expect(game.player_ships).to be_a String
  # end
  #
  # it "can tell a ships name" do
  #   expect(game.player_ship_name).to eq('Cruiser')
  #   expect(game.computer_ship_name(1)).to eq('Submarine')
  # end
  #
  # it "can call a players board details" do
  #   expect(game.computer_board).to include(Enumerable)
  #   expect(game.player_board).to include(Enumerable)
  #   expect(game.computer_board).to include(Hash)
  #   expect(game.player_board).to include(Hash)
  # end
  #
  # it "can tell when ships have been placed on the board" do
  #   expect(game.ship_check).to eq(false)
  # end
  #
  # it "can tell a ships length" do
  #   expect(game.player_ship_length).to eq(3)
  #   expect(game.computer_ship_length).to eq(3)
  # end
  #
  # it "can tell when all ships have been placed" do
  #   expect(game.ships_placed?).to eq(false)
  # end
  #
  # it "can grab a ship to place" do
  #   expect(game.ship).to be_instance_of Ship
  # end
  #
  # it "can check if user wants to quit" do
  #   @input = 'quit'
  #   expect(game.input_validation).to raise_error SystemExit
  #   @input = 'a1'
  #   expect(game.input_validation).not_to raise_error SystemExit
  # end
  #
  # xit "can grab a ship to place" do
  #   expect(game.ship).to be_instance_of Ship
  # end
end
