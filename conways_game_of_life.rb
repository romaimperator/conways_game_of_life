$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))

require 'conways_game_of_life'

@quit = false

def main
  game_runner = GameRunner.new(
    GameBoard.new([
                    [false, false, false, false, false],
                    [false, false, true, false, false],
                    [false, false, false, true, false],
                    [false, true, true, true, false],
                    [false, false, false, false, false],
                  ])
  )

  loop do
    break if @quit

    game_runner.next_generation!
    GameBoardPrinter.print(game_runner.board)
    sleep 1
  end
end

trap("SIGINT") { @quit = true }

main