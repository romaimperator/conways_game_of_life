class GameBoard
  attr_reader :board

  def initialize(starting_board=[])
    @board = starting_board
  end

  def next_state
    GameBoard.new(
      [
        [false, false, false],
        [false, false, false],
        [false, false, false]
      ]
    )
  end

  def ==(other)
    board == other.board
  end
end