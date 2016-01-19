require 'spec_helper'

RSpec.describe GameBoard do
  describe "#neighbors" do
    Given(:game_board) { GameBoard.new([
                                         [false, true, false],
                                         [true, true, false],
                                         [false, true, false]
                                       ])}
    Then { expect(game_board.neighbors(1, 1)).to be_a(Enumerator) }

    context "when checking center" do
      Then { expect { |b| game_board.neighbors(1, 1, &b) }.to yield_successive_args(false, true, false,
                                                                                    true, false,
                                                                                    false, true, false) }
    end

    context "when checking a top edge" do
      Then { expect { |b| game_board.neighbors(0, 1, &b) }.to yield_successive_args(false, false, false,
                                                                                    false, false,
                                                                                    true, true, false) }
    end

    context "when checking a bottom edge" do
      Then { expect { |b| game_board.neighbors(2, 1, &b) }.to yield_successive_args(true, true, false,
                                                                                    false, false,
                                                                                    false, false, false) }
    end

    context "when checking a left edge" do
      Then { expect { |b| game_board.neighbors(1, 0, &b) }.to yield_successive_args(false, false, true,
                                                                                    false, true,
                                                                                    false, false, true) }
    end

    context "when checking a right edge" do
      Then { expect { |b| game_board.neighbors(1, 2, &b) }.to yield_successive_args(true, false, false,
                                                                                    true, false,
                                                                                    true, false, false) }
    end

    context "when checking both top edge and left edge" do
      Then { expect { |b| game_board.neighbors(0, 0, &b) }.to yield_successive_args(false, false, false,
                                                                                    false, true,
                                                                                    false, true, true) }
    end
  end
end