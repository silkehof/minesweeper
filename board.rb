require "./tile.rb"
require "colorize"

class Board
    attr_accessor :grid

    def initialize(height, width, bombs)
        @height = height
        @width = width 
        @bombs = bombs
        @grid = []
        
        self.create_tiles
        self.place_bombs
    end

    def create_tiles
        (0...@height).each do |row_i|
            row = []
            (0...@width).each do |col_i|
                row << Tile.new(self, row_i, col_i)
            end
            @grid << row
        end
    end

    def place_bombs
        all_tiles = @grid.flatten
        all_tiles.shuffle!

        all_tiles[0..@bombs].each { |tile| tile.bomb = true }
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

    def valid_pos?(guessed_pos)
        guessed_pos[0].between?(0, @height - 1) &&
            guessed_pos[1].between?(0, @width - 1) &&
                guessed_pos.count == 2
    end

    def render_row(row, row_num)
        string = "#{row_num} "
        row.each do |tile|
            string = string + "#{tile.face_value}" + " "
        end
        
        puts string
    end

    def render
        row_num = 0

        puts "  " + (0...@width).to_a.join(" ")
        @grid.each do |row|
            render_row(row, row_num)
            row_num += 1
        end
        puts
    end

    def final_render
        all_tiles = @grid.flatten

        all_tiles.each do |tile|
            if tile.bomb == true
                tile.face_value = "B".colorize(:color => :white, :background => :red)
            end
        end

        self.render
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