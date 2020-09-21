require "./board.rb"
require "./tile.rb"
require "yaml"
require "colorize"

class Game
    def initialize(height, width, bombs)
        @board = Board.new(height, width, bombs)
    end

    def get_command
        command = nil
        until command && valid_command?(command)
            puts "Please enter a command (r for reveal / f for flag / s for save and exit game):"
            print "> "

            command = gets.chomp
        end
        command
    end

    def valid_command?(command)
        command == "r" || command == "f" || command == "s"
    end

    def get_pos # returns array with pos as two integers, e.g. [1, 2]
        guessed_pos = nil
        
        until guessed_pos && @board.valid_pos?(guessed_pos)
            puts "Please enter a position in format row, column: e.g. ‘2, 3‘:"
            print "> "

            user_input = gets.chomp
            guessed_pos = []

            user_input.split(",").each do |char|
                guessed_pos << Integer(char)
            end
        end

        guessed_pos
    end

    def guess(pos)
        tile = @board[pos]

        if tile.bomb == true
            puts "You revealed a bomb and lost the game!"
            File.delete("game.yml")
            raise "Game over"
        else
            tile.reveal
        end
    end

    def flag_tile(pos)
        tile = @board[pos]

        tile.flag
    end

    def save_game
        File.open("game.yml", "w") { |file| file.write(self.to_yaml) }
        puts "The game has been saved and ended."
        raise "Game saved"
    end

    def run
        while @board.unrevealed_empty_tiles > 0
            system("clear")
            @board.render

            command = get_command
            self.save_game if command == "s"

            pos = get_pos
            
            if command == "r"
                guess(pos)
            elsif command == "f"
                flag_tile(pos)
            end
        end

        puts "Congratulations, you won the game!"
    end

end


if __FILE__ == $PROGRAM_NAME
    if File.exist?("game.yml")
        game = YAML.load(File.read("game.yml")) 
    else
        game = Game.new(9, 9, 10)
    end
    game.run
end