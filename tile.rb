require "./board.rb"

class Tile
    def initialize(face_value)
        @flagged = false
        @bombed = false
        @revealed = false
        @face_value = face_value
    end

    def reveal
        revealed = true if @revealed == false
        @face_value = self.neighbors_bomb_count
    end

    #def neighbors
        #returns array with the pos of all neighbors of the tile
    #end

    def neighbors_bomb_count
        count = 0
        self.neighbors.each do |tile|
            count += 1 if tile.face_value == "B"
        end

        count
    end

    #def flag
    #end

    #def inspect
    #end



end