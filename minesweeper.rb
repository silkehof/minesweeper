require "./board.rb"
require "./tile.rb"

class Game
    def initialize
        @board = Board.new
    end

    def get_command
        puts "Please enter a command (r for reveal / f for flag):"
        print "> "

        user_input = gets.chomp
        user_input[0]
    end

    def get_pos # returns array with pos as two integers, e.g. [1, 2]
        puts "Please enter a position in format row, column: e.g. ‘f 2, 3‘:"
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

    def flag_tile(pos)
        tile = @board[pos]

        tile.flag
    end


    def run
        while @board.unrevealed_empty_tiles > 0
            system("clear")
            @board.render
            command = get_command
            pos = get_pos
            
            if command == "r"
                guess(pos)
            else
                flag_tile(pos)
            end
        end

        puts "Congratulations, you won the game!"
    end

end


if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.run
end