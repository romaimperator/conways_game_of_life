require 'spec_helper'

RSpec.describe GameBoard do
  describe "#==" do
    Given(:game_board) { GameBoard.new([
                                         [false, false],
                                         [false, true],
                                       ])}
    Then { expect(game_board).to eq(GameBoard.new([
                                                    [false, false],
                                                    [false, true]
                                                  ]))}
  end
end