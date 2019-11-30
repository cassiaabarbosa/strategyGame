import SpriteKit

class Grid: SKNode {

    var tiles: [Tile] = [Tile]()
    var ableTiles: [Tile] = [Tile]()
    let gridAspect: (Int, Int) // width, height
    let tileSize: CGSize
    var tileSet: String?
    
    init(position: CGPoint, width: Int, height: Int, tileSize: CGSize) {
        self.gridAspect = (width, height)
        self.tileSize = tileSize
        super.init()
        self.position = position
    }
    
    func drawGrid(tileSet: String) {
        let charArray: [String.Element] = Array(tileSet)
        let amout: Int = gridAspect.0 * gridAspect.1
        for id in 0..<amout {
            let row: Int = id / gridAspect.0
            let col: Int = id % gridAspect.0
            let tile: Tile = Tile(id: id, row: row, col: col, rectSide: tileSize.width, type: charArray[id])
            tiles.append(tile)
            addChild(tile)
        }
    }
    
    func removeHighlights() {
       for t in self.ableTiles {
           t.shader = nil
       }
       self.ableTiles.removeAll()
    }
    
    func getTile(col: Int, row: Int) -> Tile? {
        let nCols = gridAspect.0
        let nRows = gridAspect.1
        if col >= nCols || col < 0 || row >= nRows || row < 0 {
            return nil
        }
        let id = col + row * nCols
        return tiles[id]
    }
    
    func getTile(id: Int) -> Tile? {
        if id >= tiles.count {
            return tiles[id]
        }
        return nil
    }
    
    func getUpTile(col: Int, row: Int) -> Tile? {
        return getTile(col: col, row: row - 1)
    }
    
    func getDownTile(col: Int, row: Int) -> Tile? {
        return getTile(col: col, row: row + 1)
    }
    
    func getLeftTile(col: Int, row: Int) -> Tile? {
        return getTile(col: col - 1, row: row)
    }
    
    func getRightTile(col: Int, row: Int) -> Tile? {
        return getTile(col: col + 1, row: row)
    }

    func getUpLeftTile(col: Int, row: Int) -> Tile? {
        guard let upTile: Tile = getTile(col: col, row: row - 1) else { return nil }
        return getTile(col: upTile.coord.col - 1, row: upTile.coord.row)
    }
    
    func getUpRightTile(col: Int, row: Int) -> Tile? {
        guard let upTile: Tile = getTile(col: col, row: row - 1) else { return nil }
        return getTile(col: upTile.coord.col + 1, row: upTile.coord.row)
    }
    
    func getDownLeftTile(col: Int, row: Int) -> Tile? {
        guard let downTile: Tile = getTile(col: col, row: row + 1) else { return nil }
        return getTile(col: downTile.coord.col - 1, row: downTile.coord.row)
    }
    
    func getDownRightTile(col: Int, row: Int) -> Tile? {
        guard let downTile: Tile = getTile(col: col, row: row + 1) else { return nil }
        return getTile(col: downTile.coord.col + 1, row: downTile.coord.row)
    }
    
    func getUpTile(tile: Tile) -> Tile? {
        return getTile(col: tile.coord.col, row: tile.coord.row - 1)
    }
    
    func getDownTile(tile: Tile) -> Tile? {
        return getTile(col: tile.coord.col, row: tile.coord.row + 1)
    }
    
    func getLeftTile(tile: Tile) -> Tile? {
        return getTile(col: tile.coord.col - 1, row: tile.coord.row)
    }
    
    func getRightTile(tile: Tile) -> Tile? {
        return getTile(col: tile.coord.col + 1, row: tile.coord.row)
    }
    
    func getUpLeftTile(tile: Tile) -> Tile? {
        guard let upTile: Tile = getTile(col: tile.coord.col, row: tile.coord.row - 1) else { return nil }
        return getTile(col: upTile.coord.col - 1, row: upTile.coord.row)
    }
    
    func getUpRightTile(tile: Tile) -> Tile? {
        guard let upTile: Tile = getTile(col: tile.coord.col, row: tile.coord.row - 1) else { return nil }
        return getTile(col: upTile.coord.col + 1, row: upTile.coord.row)
    }
    
    func getDownLeftTile(tile: Tile) -> Tile? {
        guard let downTile: Tile = getTile(col: tile.coord.col, row: tile.coord.row + 1) else { return nil }
        return getTile(col: downTile.coord.col - 1, row: downTile.coord.row)
    }
    
    func getDownRightTile(tile: Tile) -> Tile? {
        guard let downTile: Tile = getTile(col: tile.coord.col, row: tile.coord.row + 1) else { return nil }
        return getTile(col: downTile.coord.col + 1, row: downTile.coord.row)
    }
    
    // Comment(Alex) - typo in func name
    func getNeightborsTiles(tile: Tile) -> [Tile?] {
        // Comment(Alex):
        // Prefer this...
        var neighbors = [Tile?]()
        // Instead of
        // var neighbors: [Tile?]() = [Tile?]()
        
        if let up: Tile = getUpTile(tile: tile) {
            if !up.hasObstacle {
                neighbors.append(up)
            }
        }
        
        if let right: Tile = getRightTile(tile: tile) {
            if !right.hasObstacle {
                neighbors.append(right)
            }
        }
        
        if let down: Tile = getDownTile(tile: tile) {
            if !down.hasObstacle {
                neighbors.append(down)
            }
        }
        
        if let left: Tile = getLeftTile(tile: tile) {
            if !left.hasObstacle {
                neighbors.append(left)
            }
        }
        
        // Comment(Alex):
        // this line is unnecessary because we never append a nil value
        neighbors.removeAll(where: { $0 == nil })
        // Comment(Alex):
        // Return type should be [Tile]?
        // neighbours*
        return neighbors
    }
    
    func getMovableTiles(currenTile: Tile) -> [Tile] {
        var movableTiles: [Tile?] = [Tile?]()
        // Comment(Alex):
        // this should use getTilesAround() method
        if let up: Tile = getUpTile(tile: currenTile) {
            if up.weight <= 100 {
                movableTiles.append(up)
            }
        }
        
        if let right: Tile = getRightTile(tile: currenTile) {
            if right.weight <= 100 {
                movableTiles.append(right)
            }
        }
        
        if let down: Tile = getDownTile(tile: currenTile) {
            if down.weight <= 100 {
                movableTiles.append(down)
            }
        }
        
        if let left: Tile = getLeftTile(tile: currenTile) {
            if left.weight <= 100 {
                movableTiles.append(left)
            }
        }
        
        // Comment(Alex):
        // this line is unnecessary because we never append a nil value
        movableTiles.removeAll(where: { $0 == nil })
        
        // Comment(Alex):
        // guard let fatalError is similar to force unwrapping, but is more verbose
        guard let movableNeighbors: [Tile] = movableTiles as? [Tile] else { fatalError("404 - Movable Tiles not founded") }
        
        return movableNeighbors
    }
    
    // Coment(Alex) - typo in func name
    // what is a group?
    func getAllNeightborsTilesInGroup(tile: Tile) -> [[Tile?]] {
        // Comment(Alex):
        // these shouldn't be optional
        // poor variable naming
        var neighbors = [Tile?]()
        var neighborsAreas = [[Tile?]]()
        var neighborsTiles = [Tile?]()
        var allTiles = [Tile?]()
        
        neighbors = getNeightborsTiles(tile: tile)
        allTiles = neighbors
        neighborsAreas.append(neighbors)
        
        while true {
            for index in 0 ..< neighbors.count {
                let aux = getNeightborsTiles(tile: neighbors[index]!)
                for adjacentTile in 0 ..< aux.count {
                    // Comment(Alex) - make allTiles a Set and use union instead
                    if !allTiles.contains(aux[adjacentTile]) {
                        allTiles.append(aux[adjacentTile])
                        neighborsTiles.append(aux[adjacentTile])
                    }
                }
            }
            if neighborsTiles.count == 0 {
                break
            }
            neighborsAreas.append(neighborsTiles)
            neighbors = neighborsTiles
            neighborsTiles.removeAll()
        }
        
        return neighborsAreas
    }
    
    func getDirection(from tile1: Tile, to tile2: Tile) -> Int? {
        // 0: up, 1: down, 2: left, 3: right
        if tile1.coord.col != tile2.coord.col && tile1.coord.row != tile2.coord.row { return nil }
        if tile1.coord.col == tile2.coord.col {
            return tile1.coord.row - tile2.coord.row > 0 ? 0 : 1
        } else {
            return tile1.coord.col - tile2.coord.col > 0 ? 2 : 3
        }
    }
    
    func getTilesAround(tile: Tile, distance: Int) -> [Tile] {
        var tiles = [Tile]()
        if distance <= 0 {
            print("Grid::getTilesAround(): returned empty array")
            return tiles
        }
        for i in 0...3 {
            var count = 0
            var lastTile: Tile = tile
            while count < distance {
                switch i {
                case 0:
                    if let t = getUpTile(tile: lastTile) {
                       tiles.append(t)
                        lastTile = t
                    }
                case 1:
                    if let t = getDownTile(tile: lastTile) {
                       tiles.append(t)
                        lastTile = t
                    }
                case 2:
                    if let t = getLeftTile(tile: lastTile) {
                       tiles.append(t)
                        lastTile = t
                    }
                case 3:
                    if let t = getRightTile(tile: lastTile) {
                       tiles.append(t)
                        lastTile = t
                    }
                default: fatalError("Grid::getTilesAround(): switch exausted")
                }
                count += 1
            }
        }
        return tiles
    }
    
    func getTilesAround(tile: Tile) -> [Tile] {
        var tiles = [Tile]()
        if let t = getUpTile(tile: tile) {
           tiles.append(t)
        }
        if let t = getDownTile(tile: tile) {
           tiles.append(t)
        }
        if let t = getLeftTile(tile: tile) {
           tiles.append(t)
        }
        if let t = getRightTile(tile: tile) {
           tiles.append(t)
        }
        return tiles
    }
    
    func getReachableTiles(fromTile: Tile, moves: Int) -> [Tile] {
        var tiles = [Tile]()
        var lastTiles = [Tile]()
        var nextTiles = [Tile]()
        if moves <= 0 {
            print("Grid::getReachableTiles(): returned empty array")
            return tiles
        }
        lastTiles.append(fromTile)
        for _ in 0..<moves {
            nextTiles.removeAll()
            for lt in lastTiles {
                let tilesAround = self.getTilesAround(tile: lt)
                for ta in tilesAround {
                    if !tiles.contains(ta) && ta.isWalkable {
                        nextTiles.append(ta)
                    }
                }
                lastTiles = nextTiles
                tiles.append(contentsOf: lastTiles)
            }
        }
        return tiles
    }
    
    func randomEmptyTile() -> Tile {
        if tiles.count == 0 { fatalError("Grid::randomEmptyTile(): Tiles array is empty") }
        
        var randTile: Tile
        repeat {
            randTile = self.tiles[Int.random(in: 0..<self.tiles.count)]
        } while !randTile.isEmpty || randTile.isOcupied
        return randTile
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
