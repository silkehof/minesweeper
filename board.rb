require "./tile.rb"

class Board
    attr_accessor :grid

    def initialize
        @grid = []
        self.create_tiles
        self.place_bombs
    end

    def create_tiles
        (0..8).each do |row_i|
            row = []
            (0..8).each do |col_i|
                row << Tile.new(self, row_i, col_i)
            end
            @grid << row
        end
    end

    def place_bombs
        all_tiles = @grid.flatten
        all_tiles.shuffle!

        all_tiles[0..9].each { |tile| tile.bomb = true }
    end

    def render_row(row, n)
        string = "#{n} "
        row.each do |tile|
            string = string + "#{tile.face_value}" + " "
        end
        
        puts string
    end

    def render
        n = 0
        puts "  0 1 2 3 4 5 6 7 8"
        @grid.each do |row|
            render_row(row, n)
            n += 1
        end
        puts
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end

    def []=(pos, value)
        x, y = pos
        tile = @grid[x][y]
        tile.face_value = value
    end

    def valid_neighbor?(row_idx, col_idx, row_i, col_i)
        row_idx.between?(0, 8) &&
            col_idx.between?(0, 8) &&
                @grid[row_idx][col_idx].revealed == false &&
                    [row_idx, col_idx] != [row_i, col_i]
    end

    def tile_neighbors(row_i, col_i)
        neighbors_array = []

        (row_i - 1..row_i + 1).each do |row_idx|
            (col_i - 1..col_i + 1).each do |col_idx|
                if valid_neighbor?(row_idx, col_idx, row_i, col_i)
                    neighbors_array << @grid[row_idx][col_idx]
                end
            end
        end

        neighbors_array
    end

    def unrevealed_empty_tiles
        count = 0

        @grid.each do |row|
            row.each do |tile|
                if tile.bomb == false && tile.revealed == false
                    count += 1
                end
            end
        end

        count
    end

end