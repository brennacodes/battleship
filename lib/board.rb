require_relative 'helper'
require_relative 'messages'

class Board
  include Messages
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
    @board_columns = @v_coordinates.group_by {|column| column[1]}
    @board_rows = @h_coordinates.group_by {|row| row[0]}
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

  def valid_shot?(coordinate)
    @cells[coordinate].fired_upon? ? false : true
  end

  def space_available
    spaces = []
    @cells.values.map {|cell| cell.ship == nil ? spaces.push(cell.coordinate) : spaces.push(nil)}
    spaces.compact
  end

  def shots_available
    shots = []
    @cells.values.select! {|cell| cell.fired == false ? shots.push(cell.coordinate) : shots.push(nil)}
    shots.compact
  end

  def valid_placement?(ship, coordinates)
    spaces = coordinates.length
    return false if ship.length != spaces
    a = @columns.map {|col| col.each_cons(spaces)}
    a = a.map {|arr| arr.map {|sub| sub}}.flatten(1)
    b = @columns.map {|col| col.reverse.each_cons(spaces)}
    b = b.map {|arr| arr.map {|sub| sub}}.flatten(1)
    c = @rows.map {|row| row.each_cons(spaces)}
    c = c.map {|arr| arr.map {|sub| sub}}.flatten(1)
    d = @rows.map {|row| row.reverse.each_cons(spaces)}
    d = d.map {|arr| arr.map {|sub| sub}}.flatten(1)
    all_places = a.concat(b, c, d)
    all_places = all_places.uniq.sort
    if all_places.any?(coordinates) == true
      true
    else
      return false
    end
    open_spaces_test = coordinates.map do |coord|
        space_available.include?(coord)
      end
    if open_spaces_test.all?(true) == true
      true
    else
      return false
    end
  end

  def place(ship, coordinates)
    coordinates.map {|coord| @cells[coord].place_ship(ship)}
  end

  def rendering(player, visibility = false)
    num = [' ⓵', ' ⓶', ' ⓷', ' ⓸']
    # , '⓹', '⓺', '⓻', '⓼', '⓽', '⓾']
    alphabet = ('A'..'J').to_a
    lets =  ['🅰', '🅱', '🅲', '🅳', '🅴', '🅵', '🅶', '🅷', '🅸', '🅹']
    letters = alphabet.zip(lets).to_h
    sym = num.zip(lets)
    sym = sym.to_h
    puts "  " + num.join(' ')
    @board_rows.each do |key, value|
      output = value.map do |v|
        @cells[v].render(player, visibility)
      end
      puts letters[key[0]] + " " + output.join(' ')
    end
  end

  def take_shot(coordinate)
    if valid_coordinate?(coordinate) == false
      invalid_coordinate
    elsif valid_shot?(coordinate) == false
      invalid_shot
    else
      @cells[coordinate].fire_upon
    end
  end
end
