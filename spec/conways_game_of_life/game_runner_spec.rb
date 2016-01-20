require 'spec_helper'

RSpec.describe GameRunner do
  describe "#after" do
    Given(:game_board) { GameBoard.new([]) }
    Given(:game_runner) { GameRunner.new(game_board) }
    Given { allow(game_board).to receive(:next_state).and_return(game_board) }
    When(:result) { game_runner.after(3) }
    Then { expect(game_board).to have_received(:next_state).exactly(3).times }
  end

  describe "#next_generation!" do
    Given(:game_board) { GameBoard.new([
                                         [false, true, false, false],
                                         [true, true, false, false],
                                         [false, false, false, false],
                                         [false, false, false, false],
                                       ]) }
    Given(:game_runner) { GameRunner.new(game_board) }
    When { game_runner.next_generation! }
    Then { expect(game_runner.board).to eq(GameBoard.new([
                                                           [true, true, false, false],
                                                           [true, true, false, false],
                                                           [false, false, false, false],
                                                           [false, false, false, false],
                                                         ]))}
  end
end