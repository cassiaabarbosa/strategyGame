import SpriteKit

class Grid: SKNode {

    var tiles: [Tile] = [Tile]()
    var ableTiles: [Tile] = [Tile]()
    let gridAspect: (Int, Int) // width, height
    let tileSize: CGSize
    var tileSet: String?
    
    init(position: CGPoint, width: Int, height: Int, tileSize: CGSize, tileSet: String) {
        self.gridAspect = (width, height)
        self.tileSize = tileSize
        super.init()
        self.position = position
        drawGrid(tileSet: tileSet)
    }
    
    private func drawGrid(tileSet: String) {
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
           t.shape?.fillShader = nil
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
    
    func getNeightborsTiles(tile: Tile) -> [Tile?] {
        var neighbors: [Tile?] = [Tile?]()
        
        neighbors.append(getUpTile(tile: tile))
        neighbors.append(getUpRightTile(tile: tile))
        neighbors.append(getRightTile(tile: tile))
        neighbors.append(getDownRightTile(tile: tile))
        neighbors.append(getDownTile(tile: tile))
        neighbors.append(getDownLeftTile(tile: tile))
        neighbors.append(getLeftTile(tile: tile))
        neighbors.append(getUpLeftTile(tile: tile))
        neighbors.removeAll(where: { $0 == nil })
        return neighbors
    }
    
    func getMovableTiles(currenTile: Tile) -> [Tile] {
        var movableTiles: [Tile?] = [Tile?]()
        movableTiles.append(getUpTile(tile: currenTile))
        movableTiles.append(getRightTile(tile: currenTile))
        movableTiles.append(getDownTile(tile: currenTile))
        movableTiles.append(getLeftTile(tile: currenTile))
        movableTiles.removeAll(where: { $0 == nil })
        guard let movableNeighbors: [Tile] = movableTiles as? [Tile] else { fatalError("404 - Movable Tiles not founded") }
        
        return movableNeighbors
    }
    
    func getAllNeightborsTilesInGroup(tile: Tile) -> [[Tile?]] {
        var neighbors: [Tile?] = [Tile?]()
        var neighborsAreas: [[Tile?]] = [[Tile?]]()
        var neighborsTiles: [Tile?] = [Tile?]()
        var allTiles: [Tile?] = [Tile?]()
        
        neighbors = getNeightborsTiles(tile: tile)
        allTiles = neighbors
        neighborsAreas.append(neighbors)
        
        while true {
            for index in 0...neighbors.count - 1 {
                let aux = getNeightborsTiles(tile: neighbors[index]!)
                for adjacentTile in 0...aux.count - 1 {
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

    func getStraightDistance(from tile1: Tile, to tile2: Tile) -> UInt? {
        if tile1.coord.col != tile2.coord.col && tile1.coord.row != tile2.coord.row { return nil }
        if tile1.coord.col == tile2.coord.col {
            return Int.Magnitude(tile1.coord.col - tile2.coord.col)
        } else {
            return Int.Magnitude(tile1.coord.row - tile2.coord.row)
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
    
    func randomEmptyTile() -> Tile {
        if tiles.count == 0 { fatalError("Grid::randomEmptyTile(): Tiles array is empty") }
        
        var randTile: Tile
        repeat {
            randTile = self.tiles[Int.random(in: 0..<self.tiles.count)]
        } while !randTile.isEmpty
        return randTile
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
