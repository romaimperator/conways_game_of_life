class GameBoardPrinter
  def self.print(game_board)
    game_board.each_row do |row|
      puts row.map { |cell| cell ? "#" : "-" }.join(" ")
    end
  end
end