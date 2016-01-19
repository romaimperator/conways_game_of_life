require 'spec_helper'

RSpec.describe "The game can run over multiple generations" do
  Given(:game_runner) { GameRunner.new(game_board) }

  describe "given a simple still life block" do
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false],
                                         [false, true, true, false],
                                         [false, true, true, false],
                                         [false, false, false, false]
                                       ])}
    Then { expect(game_runner.after(1)).to eq(game_board) }
    Then { expect(game_runner.after(2)).to eq(game_board) }
    Then { expect(game_runner.after(3)).to eq(game_board) }
  end

  describe "given an oscillator" do
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false, false],
                                         [false, false, false, false, false],
                                         [false, true, true, true, false],
                                         [false, false, false, false, false],
                                         [false, false, false, false, false],
                                       ])}
    Given(:oscillated_board) { GameBoard.new([
                                               [false, false, false, false, false],
                                               [false, false, true, false, false],
                                               [false, false, true, false, false],
                                               [false, false, true, false, false],
                                               [false, false, false, false, false],
                                             ])}
    Then { expect(game_runner.after(1)).to eq(oscillated_board) }
    Then { expect(game_runner.after(2)).to eq(game_board) }
    Then { expect(game_runner.after(3)).to eq(oscillated_board) }
    Then { expect(game_runner.after(4)).to eq(game_board) }
    Then { expect(game_runner.after(5)).to eq(oscillated_board) }
  end

  describe "given a spaceship" do
    # Where '#' is a live cell and '-' is a dead cell, this spaceship looks like:
    #  - - - - -
    #  - - # - -
    #  - - - # -
    #  - # # # -
    #  - - - - -
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false, false],
                                         [false, false, true, false, false],
                                         [false, false, false, true, false],
                                         [false, true, true, true, false],
                                         [false, false, false, false, false],
                                       ])}
    #  - - - - -
    #  - - - - -
    #  - # - # -
    #  - - # # -
    #  - - # - -
    Then { expect(game_runner.after(1)).to eq(GameBoard.new([
                                                              [false, false, false, false, false],
                                                              [false, false, false, false, false],
                                                              [false, true, false, true, false],
                                                              [false, false, true, true, false],
                                                              [false, false, true, false, false],
                                                            ]))}
    #  - - - - -
    #  - - - - -
    #  - - - # -
    #  - # - # -
    #  - - # # -
    Then { expect(game_runner.after(2)).to eq(GameBoard.new([
                                                              [false, false, false, false, false],
                                                              [false, false, false, false, false],
                                                              [false, false, false, true, false],
                                                              [false, true, false, true, false],
                                                              [false, false, true, true, false],
                                                            ]))}
    #  - - - - -
    #  - - - - -
    #  - - # - -
    #  - - - # #
    #  - - # # -
    Then { expect(game_runner.after(3)).to eq(GameBoard.new([
                                                              [false, false, false, false, false],
                                                              [false, false, false, false, false],
                                                              [false, false, true, false, false],
                                                              [false, false, false, true, true],
                                                              [false, false, true, true, false],
                                                            ]))}
    # Then it repeats the same shape but shifted down and right one cell
    #  - - - - -
    #  - - - - -
    #  - - - # -
    #  - - - - #
    #  - - # # #
    Then { expect(game_runner.after(4)).to eq(GameBoard.new([
                                                              [false, false, false, false, false],
                                                              [false, false, false, false, false],
                                                              [false, false, false, true, false],
                                                              [false, false, false, false, true],
                                                              [false, false, true, true, true],
                                                            ]))}
  end
end