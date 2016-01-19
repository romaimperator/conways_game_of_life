require 'spec_helper'

RSpec.describe "The game can run over multiple generations" do
  describe "given a simple still life block" do
    Given(:game_board) { GameBoard.new([
                                         [false, false, false, false],
                                         [false, true, true, false],
                                         [false, true, true, false],
                                         [false, false, false, false]
                                       ])}
    Then { expect(game_board.next_state).to eq(game_board) }
    Then { expect(game_board.next_state.next_state).to eq(game_board) }
    Then { expect(game_board.next_state.next_state.next_state).to eq(game_board) }
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
    Then { expect(game_board.next_state).to eq(oscillated_board) }
    Then { expect(game_board.next_state.next_state).to eq(game_board) }
    Then { expect(game_board.next_state.next_state.next_state).to eq(oscillated_board) }
  end
end