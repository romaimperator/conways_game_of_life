require 'spec_helper'

RSpec.describe GameBoard do
  describe "#==" do
    Given(:game_board) { GameBoardParser.parse_into_game_board("..
                                                                .O") }
    Then { expect(game_board).to eq(GameBoardParser.parse_into_game_board("..
                                                                           .O"))}
  end

  describe "#each_row" do
    Given(:game_board) { GameBoardParser.parse_into_game_board("..
                                                                .O") }
    Then { expect { |b| game_board.each_row(&b) }.to yield_successive_args([false, false], [false, true]) }
  end
end