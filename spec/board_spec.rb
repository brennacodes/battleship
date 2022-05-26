require './lib/helper'

RSpec.describe do
  let!(:board) {Board.new(10, 10)}
  let!(:board1) {Board.new(4, 4)}
  let!(:board2) {Board.new(5, 10)}
  let!(:board3) {Board.new(10, 7)}
  let!(:makes_cells) {board1.cells}
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}

  it "is an instance of" do
    expect(board1).to be_instance_of Board
  end

  it "has cells" do
    expect(board1.cells).to be_a Hash
    expect(board.cells.count).to eq(100)
    expect(board1.cells.count).to eq(16)
    expect(board2.cells.count).to eq(50)
    expect(board3.cells.count).to eq(70)
  end

  it "has cell objects" do
    expect(board1.cells["A1"]).to be_instance_of Cell
  end

  it "can validate coordinates" do
    expect(board1.valid_coordinate?("A1")).to be true
    expect(board1.valid_coordinate?("D4")).to be true
    expect(board1.valid_coordinate?("A5")).to be false
    expect(board1.valid_coordinate?("E1")).to be false
    expect(board1.valid_coordinate?("A22")).to be false
  end

  it "can check valid placement" do
    expect(board1.valid_placement?(cruiser, ["A1", "A2"])).to eq false
    expect(board1.valid_placement?(submarine, ["A1", "A5"])).to eq false
    expect(board1.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq true
    expect(board1.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq false
    expect(board1.valid_placement?(submarine, ["A1", "B1"])).to eq true
    expect(board1.valid_placement?(submarine, ["A1", "A2"])).to eq true
    expect(board1.valid_placement?(submarine, ["A1", "B2"])).to eq false
    expect(board1.valid_placement?(submarine, ["C2", "D3"])).to eq false
    expect(board1.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq true
    expect(board1.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq true
  end

  it "can check if space is occupied" do
    expect(board1.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq true
    board1.place(cruiser, ["A1", "A2", "A3"])
    expect(board1.valid_placement?(submarine, ["A1", "A2"])).to eq false
  end

  it "can place ships" do
    board1.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board1.cells["A1"]
    cell_2 = board1.cells["A2"]
    cell_3 = board1.cells["A3"]
    expect(cell_1.ship).to be_instance_of Ship
    cell_1.ship == cell_2.ship
    cell_2.ship == cell_3.ship
  end

  it "can render board properly" do
    expect(board1.rendering).to eq({"A"=>["A1", "A2", "A3", "A4"], "B"=>["B1", "B2", "B3", "B4"], "C"=>["C1", "C2", "C3", "C4"], "D"=>["D1", "D2", "D3", "D4"]})
  end

  # xit 'can render a board and show ships' do
  # board1.place(cruiser, ["A1", "A2", "A3"])
  # # expect(board1.rendering(true)).to eq("  ⓵ ⓶ ⓷ ⓸\nA 🚢 S S .\nB . . . .\nC . . . .\nD . . . .\n")
  # expect(board1.rendering(true)).to eq("  ⓵ ⓶ ⓷ ⓸\n🅰 🚢 🚢 🚢 🌊\n🅱 🌊 🌊 🌊 🌊\\n🅲 🌊 🌊 🌊 🌊\\n🅳 🌊 🌊 🌊 🌊\\n")
  # end
end
