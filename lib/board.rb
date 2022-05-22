class Board
  attr_reader :cells, :coordinates, :vert_coords, :letters, :nums

  def initialize
    @coordinates = make_horizontal_coordinates
    @vert_coords = make_vertical_coordinates
    @cells = make_cells
    @letters = letters
    @nums = nums
  end

  def make_horizontal_coordinates
    @letters = ("A".."D").to_a
    @nums = (1..4).to_a
    @coordinates = letters.product(nums).map {|coord| coord.join('')}
  end

  def make_vertical_coordinates
    @letters = ("A".."D").to_a
    @nums = (1..4).to_a
    @vert_coords = nums.product(letters).map {|num| num.join('').reverse}
  end

  def make_cells
    @cells = @coordinates.to_h {|cell| [cell, Cell.new(cell)]}
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, placement)
    return false if ship.length != placement.length

    placement.each do |cell|
      if valid_coordinate?(cell) == false
        return false
      end
    end

    placement.each do |coord|
      if @cells[coord].ship != nil
        return false
      end
    end

    letters = []
    numbers = []
    letters_ord = []

    placement.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1].to_i
    end

    letters.each do |letter|
      letters_ord << letter.ord
    end

    if letters.uniq.size == 1 && numbers[-1] == (numbers[0] + (numbers.count - 1))
      return true
    elsif numbers.uniq.size == 1 && letters_ord[-1] == (letters_ord[0] + (letters.count - 1))
      return true
    else
      return false
    end
  end

  def place(ship, coordinates)
    coordinates.map {|coord| @cells[coord].place_ship(ship)}
  end

  def render(boolean = false)
    line_1 = []
    line_2 = []
    line_3 = []
    line_4 = []
    @coordinates[0..(@letters.length-1)].each do |coordinate|
      line_1 << @cells[coordinate].render(boolean)
    end
    @coordinates[@letters.length..7].each do |coordinate|
      line_2 << @cells[coordinate].render(boolean)
    end
    @coordinates[8..11].each do |coordinate|
      line_3 << @cells[coordinate].render(boolean)
    end
    @coordinates[12..15].each do |coordinate|
      line_4 << @cells[coordinate].render(boolean)
    end
    puts "  #{nums * " "} \n"
    puts "#{@letters[0]} #{line_1 * " "}"
    puts "#{@letters[1]} #{line_2 * " "}"
    puts "#{@letters[2]} #{line_3 * " "}"
    puts "#{@letters[3]} #{line_4 * " "}"

  end

  def track_cells

  end
end
