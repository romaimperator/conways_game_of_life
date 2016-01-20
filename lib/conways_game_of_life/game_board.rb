class GameBoard
  attr_reader :board

  def initialize(starting_board=[])
    @board = starting_board
  end

  def next_state
    GameBoard.new(map_cell_with_live_neighbor_count { |cell, live_neighbors|
      if (cell && live_neighbors == 2) || live_neighbors == 3
        true
      else
        false
      end
    })
  end

  def each_row
    return to_enum(__callee__) unless block_given?

    board.each do |row|
      yield row
    end
  end

  def ==(other)
    board == other.board
  end

  private

  def map_cell_with_live_neighbor_count
    new_board = duplicate_board
    each_cell_with_location do |cell, (row_number, column_number)|
      live_neighbors = neighbors(row_number, column_number).count(true)
      new_board[row_number][column_number] = yield cell, live_neighbors
    end
    new_board
  end

  def duplicate_board
    board.map { |row| row.map { |cell| cell } }
  end

  def each_cell_with_location
    board.each_with_index do |row, row_number|
      row.each_with_index do |cell, cell_number|
        yield cell, [row_number, cell_number]
      end
    end
  end

  def neighbors(row_number, column_number)
    return to_enum(__callee__, row_number, column_number) unless block_given?

    wrapped_neighbor_locations(row_number, column_number) do |neighbor_row, neighbor_column|
      yield board[neighbor_row][neighbor_column]
    end
  end

  def in_board_bounds?(neighbor_row, neighbor_column)
    (neighbor_row >= 0 && neighbor_row < board.size) &&
      (neighbor_column >= 0 && neighbor_column < board.size)
  end

  def wrapped_neighbor_locations(row_number, column_number)
    neighbor_locations(row_number, column_number) do |neighbor_row, neighbor_column|
      yield wrap_around_board(neighbor_row),
            wrap_around_board(neighbor_column)
    end
  end

  def wrap_around_board(index)
    if index < 0
      board.size - 1
    elsif index >= board.size
      0
    else
      index
    end
  end

  def neighbor_locations(row_number, column_number)
    neighbor_offsets do |row_modifier, column_modifier|
      yield row_number + row_modifier,
            column_number + column_modifier
    end
  end

  def neighbor_offsets
    row_modifier = -1
    3.times do
      column_modifier = -1
      3.times do
        if is_neighboring_cell?(row_modifier, column_modifier)
          yield row_modifier, column_modifier
        end
        column_modifier += 1
      end
      row_modifier += 1
    end
  end

  def is_neighboring_cell?(row_modifier, column_modifier)
    row_modifier != 0 || column_modifier != 0
  end
end