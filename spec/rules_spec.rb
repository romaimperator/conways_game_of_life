require 'spec_helper'

RSpec.describe "Rules to Conway's Game of Life" do
  describe "any living cell with fewer than two live neighbors dies" do
    context "only a single cell is alive" do
      Given(:game_board) { GameBoardParser.parse_into_game_board("...
                                                                  .O.
                                                                  ...") }
      Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board("...
                                                                                        ...
                                                                                        ...")) }
    end

    context "there is one living neighbor cell" do
      Given(:game_board) { GameBoardParser.parse_into_game_board("...
                                                                  .OO
                                                                  ...") }
      Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board("...
                                                                                        ...
                                                                                        ...")) }
    end
  end

  describe "any living cell with two or three neighbors lives on" do
    context "there are two living neighbors" do
      Given(:game_board) { GameBoardParser.parse_into_game_board(".O..
                                                                  .O..
                                                                  .O..
                                                                  ....") }
      Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board("....
                                                                                        OOO.
                                                                                        ....
                                                                                        ....")) }
    end

    context "there are three living neighbors" do
      Given(:game_board) { GameBoardParser.parse_into_game_board(".....
                                                                  .OO..
                                                                  ..O..
                                                                  ..O..
                                                                  .....") }
      Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                        .OO..
                                                                                        ..OO.
                                                                                        .....
                                                                                        .....")) }
    end
  end

  describe "any living cell with more than three neighbors dies" do
    Given(:game_board) { GameBoardParser.parse_into_game_board(".....
                                                                .OO..
                                                                ..OO.
                                                                ..O..
                                                                .....") }
    Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                      .OOO.
                                                                                      ...O.
                                                                                      ..OO.
                                                                                      .....")) }
  end

  describe "any dead cell with exactly three live neighbors comes alive" do
    Given(:game_board) { GameBoardParser.parse_into_game_board(".....
                                                                .O...
                                                                ...O.
                                                                ..O..
                                                                .....") }
    Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                      .....
                                                                                      ..O..
                                                                                      .....
                                                                                      .....")) }
  end

  describe "the sides of the board wrap" do
    Given(:game_board) { GameBoardParser.parse_into_game_board(".....
                                                                .....
                                                                ...O.
                                                                ....O
                                                                ..OOO") }
    Then { expect(game_board.next_state).to eq(GameBoardParser.parse_into_game_board("...O.
                                                                                      .....
                                                                                      .....
                                                                                      ..O.O
                                                                                      ...OO")) }
  end
end