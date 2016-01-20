class GameBoardParser
  def self.parse_into_game_board(string_board)
    GameBoard.new(parse(string_board))
  end

  def self.parse(string_board)
    parsed_board = [[]]
    string_board.chars.each do |char|
      if char == 'O'
        parsed_board.last << true
      elsif char == '.'
        parsed_board.last << false
      elsif char == "\n"
        parsed_board << []
      end
    end
    parsed_board
  end
end