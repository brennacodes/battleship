require_relative 'cell'
require_relative 'ship'

class Board
  attr_reader :cells,
              :h_coordinates,
              :v_coordinates,
              :letters,
              :numbers,
              :rows,
              :columns,
              :board_rows,
              :board_columns

  def initialize
    @h_coordinates = make_horizontal_coordinates
    @v_coordinates = make_vertical_coordinates
    @cells = make_cells
    @board_columns = @h_coordinates.group_by {|column| column[1]}
    @board_rows = @h_coordinates.group_by {|column| column[0]}
    @columns = @board_columns.values
    @rows = @board_rows.values
  end

  def make_horizontal_coordinates
    @letters = ("A".."D").to_a
    @numbers = (1..4).to_a
    @h_coordinates = @letters.product(numbers).map {|coord| coord.join('')}
  end

  def make_vertical_coordinates
    @v_coordinates = @numbers.product(letters).map {|num| num.join('').reverse}
  end

  def make_cells
    @cells = @h_coordinates.to_h {|cell| [cell, Cell.new(cell)]}
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def space_available
    @cells.values.map {|cell| cell.ship == nil ? cell.coordinate : ""}.compact
  end

  def valid_placement?(ship, coordinates)
    spaces = coordinates.length
    return false if ship.length != spaces

    space = space_available
    coordinates.each do |coord|
      return false if space.include?(coord) == false
    end

    check = @columns.map do |col|
      col.each_cons(spaces).include?(coordinates)
    end
    check2 = @rows.map do |row|
      row.each_cons(spaces).include?(coordinates)
    end
    check.any?(true) == true || check2.any?(true) == true ? true : false
  end

  def place(ship, coordinates)
    coordinates.map {|coord| @cells[coord].place_ship(ship)}
  end

  def rendering(visibility = false)
    puts "  " + @numbers.join(' ')
    @board_rows.each do |key, value|
      output = value.map do |v|
        @cells[v].render(visibility)
      end
      puts key[0] + " " + output.join(' ')
    end
  end
end
