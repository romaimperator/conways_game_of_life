require 'spec_helper'

RSpec.describe GameBoardParser do
  describe ".parse" do
    Given(:string_board) { "...
                            O..
                            .O." }
    When(:result) { GameBoardParser.parse(string_board) }
    Then { expect(result).to eq([
                                  [false, false, false],
                                  [true, false, false],
                                  [false, true, false],
                                ]) }
  end

  describe ".parse_into_game_board" do
    Given(:string_board) { "O..
                            O.O
                            .O." }
    When(:result) { GameBoardParser.parse_into_game_board(string_board) }
    Then { expect(result).to eq(GameBoard.new([
                                                [true, false, false],
                                                [true, false, true],
                                                [false, true, false],
                                              ])) }
  end
end