class GameRunner
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def after(number_of_generations)
    number_of_generations.times do
      @board = @board.next_state
    end
    @board
  end

  def next_generation!
    @board = @board.next_state
  end
end