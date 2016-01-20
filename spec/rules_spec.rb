require 'spec_helper'

RSpec.describe "Rules to Conway's Game of Life" do
  describe "any living cell with fewer than two live neighbors dies" do
    context "only a single cell is alive" do
      Given(:game_board) { GameBoard.new([
                                           [false, false, false],
                                           [false, true, false],
                                           [false, false, false]
                                         ]) }
      Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                                 [false, false, false],
                                                                 [false, false, false],
                                                                 [false, false, false]
                                                               ])) }
    end

    context "there is one living neighbor cell" do
      Given(:game_board) { GameBoard.new([
                                           [false, false, false],
                                           [false, true, true],
                                           [false, false, false]
                                         ])}
      Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                                 [false, false, false],
                                                                 [false, false, false],
                                                                 [false, false, false]
                                                               ])) }
    end
  end

  describe "any living cell with two or three neighbors lives on" do
    context "there are two living neighbors" do
      Given(:game_board) { GameBoard.new([
                                           [false, true, false, false],
                                           [false, true, false, false],
                                           [false, true, false, false],
                                           [false, false, false, false]
                                         ])}
      Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                                 [false, false, false, false],
                                                                 [true, true, true, false],
                                                                 [false, false, false, false],
                                                                 [false, false, false, false],
                                                               ]))}
    end

    context "there are three living neighbors" do
      Given(:game_board) { GameBoard.new([
                                           [false, false, false, false, false],
                                           [false, true, true, false, false],
                                           [false, false, true, false, false],
                                           [false, false, true, false, false],
                                           [false, false, false, false, false],
                                         ])}
      Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                                 [false, false, false, false, false],
                                                                 [false, true, true, false, false],
                                                                 [false, false, true, true, false],
                                                                 [false, false, false, false, false],
                                                                 [false, false, false, false, false],
                                                               ]))}
    end
  end

  describe "any living cell with more than three neighbors dies" do
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false, false],
                                         [false, true, true, false, false],
                                         [false, false, true, true, false],
                                         [false, false, true, false, false],
                                         [false, false, false, false, false],
                                       ])}
    Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                               [false, false, false, false, false],
                                                               [false, true, true, true, false],
                                                               [false, false, false, true, false],
                                                               [false, false, true, true, false],
                                                               [false, false, false, false, false],
                                                             ]))}
  end

  describe "any dead cell with exactly three live neighbors comes alive" do
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false, false],
                                         [false, true, false, false, false],
                                         [false, false, false, true, false],
                                         [false, false, true, false, false],
                                         [false, false, false, false, false],
                                       ])}
    Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                               [false, false, false, false, false],
                                                               [false, false, false, false, false],
                                                               [false, false, true, false, false],
                                                               [false, false, false, false, false],
                                                               [false, false, false, false, false],
                                                             ]))}
  end

  describe "the sides of the board wrap" do
    #  - - - - -
    #  - - - - -
    #  - - - # -
    #  - - - - #
    #  - - # # #
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false, false],
                                         [false, false, false, false, false],
                                         [false, false, false, true, false],
                                         [false, false, false, false, true],
                                         [false, false, true, true, true],
                                       ]) }
    # - - - # -
    # - - - - -
    # - - - - -
    # - - # - #
    # - - - # #
    Then { expect(game_board.next_state).to eq(GameBoard.new([
                                                               [false, false, false, true, false],
                                                               [false, false, false, false, false],
                                                               [false, false, false, false, false],
                                                               [false, false, true, false, true],
                                                               [false, false, false, true, true],
                                                             ]))}
  end
end