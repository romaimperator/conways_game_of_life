require 'spec_helper'

RSpec.describe "The game can run over multiple generations" do
  Given(:game_runner) { GameRunner.new(game_board) }

  describe "given a simple still life block" do
    Given(:game_board) { GameBoardParser.parse_into_game_board("....
                                                                .OO.
                                                                .OO.
                                                                ....") }
    Then { expect(game_runner.after(1)).to eq(game_board) }
    Then { expect(game_runner.after(2)).to eq(game_board) }
    Then { expect(game_runner.after(3)).to eq(game_board) }
  end

  describe "given an oscillator" do
    Given(:game_board) { GameBoardParser.parse_into_game_board(".....
                                                                .....
                                                                .OOO.
                                                                .....
                                                                .....") }
    Given(:oscillated_board) { GameBoardParser.parse_into_game_board(".....
                                                                      ..O..
                                                                      ..O..
                                                                      ..O..
                                                                      .....") }
    Then { expect(game_runner.after(1)).to eq(oscillated_board) }
    Then { expect(game_runner.after(2)).to eq(game_board) }
    Then { expect(game_runner.after(3)).to eq(oscillated_board) }
    Then { expect(game_runner.after(4)).to eq(game_board) }
    Then { expect(game_runner.after(5)).to eq(oscillated_board) }
  end

  describe "given a spaceship" do
    Given(:game_board) { GameBoardParser.parse_into_game_board(".....
                                                                ..O..
                                                                ...O.
                                                                .OOO.
                                                                .....") }
    Then { expect(game_runner.after(1)).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                     .....
                                                                                     .O.O.
                                                                                     ..OO.
                                                                                     ..O.."))}
    Then { expect(game_runner.after(2)).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                     .....
                                                                                     ...O.
                                                                                     .O.O.
                                                                                     ..OO."))}
    Then { expect(game_runner.after(3)).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                     .....
                                                                                     ..O..
                                                                                     ...OO
                                                                                     ..OO."))}
    # Then it repeats the same shape but shifted down and right one cell
    Then { expect(game_runner.after(4)).to eq(GameBoardParser.parse_into_game_board(".....
                                                                                     .....
                                                                                     ...O.
                                                                                     ....O
                                                                                     ..OOO"))}
  end
end