struct Coord {
    
    var row: Int
    var col: Int
    
    var up: Coord {
        return Coord(self.row - 1, self.col)
    }
    
    var down: Coord {
        return Coord(self.row + 1, self.col)
    }
    
    var right: Coord {
        return Coord(self.row, self.col + 1)
    }
    
    var left: Coord {
        return Coord(self.row, self.col - 1)
    }
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
}
