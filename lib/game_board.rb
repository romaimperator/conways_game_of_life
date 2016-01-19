class GameBoard
  attr_reader :board

  def initialize(starting_board=[])
    @board = starting_board
  end

  def next_state
    new_board = board.map { |row| row.map {|cell| cell } }
    live_neighbors = neighbors(1, 1).count { |cell| cell }
    if live_neighbors == 2 || live_neighbors == 3
      new_board[1][1] = true
    else
      new_board[1][1] = false
    end
    GameBoard.new(new_board)
  end

  def neighbors(row_number, column_number)
    return to_enum(__callee__, row_number, column_number) unless block_given?

    neighbor_locations(row_number, column_number) do |neighbor_row, neighbor_column|
      if in_board_bounds?(neighbor_row, neighbor_column)
        yield board[neighbor_row][neighbor_column]
      else
        yield false
      end
    end
  end

  def ==(other)
    board == other.board
  end

  private

  def neighbor_locations(row_number, column_number)
    neighbor_offsets do |row_modifier, column_modifier|
      yield row_number + row_modifier,
            column_number + column_modifier
    end
  end

  def neighbor_offsets
    return to_enum(__callee__) unless block_given?

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

  def in_board_bounds?(neighbor_row, neighbor_column)
    (neighbor_row >= 0 && neighbor_row < board.size) &&
      (neighbor_column >= 0 && neighbor_column < board.size)
  end

  def is_neighboring_cell?(row_modifier, column_modifier)
    row_modifier != 0 || column_modifier != 0
  end
end