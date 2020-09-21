require "./board.rb"

class Tile
    attr_accessor :face_value, :bomb, :revealed
    attr_reader :board

    def initialize(board, row_i, col_i)
        @flagged = false
        @bomb = false
        @revealed = false
        @face_value = "*"
        @row_i = row_i
        @col_i = col_i
        @board = board
    end

    def reveal
        @revealed = true

        if self.neighbors_bomb_count == 0
            @face_value = "_"
            self.neighbors.each do |neighbor|
                neighbor.reveal
            end
        else 
            @face_value = self.neighbors_bomb_count
        end
    end

    def neighbors
        @board.tile_neighbors(@row_i, @col_i)
    end

    def neighbors_bomb_count
        count = 0
        self.neighbors.each do |neighbor|
            count += 1 if neighbor.bomb == true
        end

        count
    end

    def flag
        @face_value = "F"
    end
end