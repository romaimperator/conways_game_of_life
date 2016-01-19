class GameRunner
  def initialize(board)
    @board = board
  end

  def after(number_of_generations)
    number_of_generations.times do
      @board = @board.next_state
    end
    @board
  end
end