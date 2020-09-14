require "./tile.rb"

class Board
    def initialize
        @grid = Array.new(9) { Array.new(9) {0} }
    end

    #Places bombs randomly: "B" equals a bomb, "X" is no bomb
    def place_bombs
        options = ["B", "X"]
        @grid.each do |row|
            row.map! do |tile|
                Tile.new(options.sample)
            end
        end
    end

    def render
        @grid.each do |row|
            row.each do |tile|
                puts tile.face_value
            end
        end
    end





end