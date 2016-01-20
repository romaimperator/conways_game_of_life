$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))

require 'conways_game_of_life'

@quit = false

def clear_screen
  puts "\e[H\e[2J"
end

def main
  game_runner = GameRunner.new(
    GameBoardParser.parse_into_game_board(".....
                                           ..O..
                                           ...O.
                                           .OOO.
                                           .....")
  )

  loop do
    break if @quit

    clear_screen
    GameBoardPrinter.print(game_runner.board)
    sleep 1
    game_runner.next_generation!
  end
end

trap("SIGINT") { @quit = true }

main