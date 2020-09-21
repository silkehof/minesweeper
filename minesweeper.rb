require "./board.rb"
require "./tile.rb"

class Game
    def initialize
        @board = Board.new
    end

    def get_input # returns array with pos as two integers, e.g. [1, 2]
        puts "Please enter a position in format row, column: e.g. ‘2, 3‘:"
        print "> "

        user_input = gets.chomp
        guessed_pos = []

        user_input.split(",").each do |char|
            guessed_pos << Integer(char)
        end

        guessed_pos
    end

    def guess(pos)
        tile = @board[pos]

        if tile.bomb == true
            puts "You revealed a bomb and lost the game!"
            raise "Game over"
        else
            tile.reveal
        end
    end

    def run
        while @board.unrevealed_empty_tiles > 0
            @board.render
            pos = get_input
            guess(pos)
        end

        puts "Congratulations, you won the game!"
    end

end