require 'rspec'
require 'rspec-given'
require 'game_board'

RSpec.describe "Rules to Conway's Game of Life" do
  describe "any living cell with fewer than two live neighbors dies" do
    Invariant { expect(game_board.next_state).to eq(GameBoard.new([
                                                                    [false, false, false],
                                                                    [false, false, false],
                                                                    [false, false, false]
                                                                  ])) }

    context "only a single cell is alive" do
      Given(:game_board) { GameBoard.new([
                                           [false, false, false],
                                           [false, true, false],
                                           [false, false, false]
                                         ]) }
      Then { game_board.next_state }
    end

    context "there is one living neighbor cell" do
      Given(:game_board) { GameBoard.new([
                                           [false, false, false],
                                           [false, true, true],
                                           [false, false, false]
                                         ])}
      Then { game_board.next_state }
    end
  end
end