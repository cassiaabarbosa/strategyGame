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
        var neighborsTiles: [Tile] = [Tile]()
        
        neighbors.append(getUpTile(tile: tile))
        neighbors.append(getUpRightTile(tile: tile))
        neighbors.append(getRightTile(tile: tile))
        neighbors.append(getDownRightTile(tile: tile))
        neighbors.append(getDownTile(tile: tile))
        neighbors.append(getDownLeftTile(tile: tile))
        neighbors.append(getLeftTile(tile: tile))
        neighbors.append(getUpLeftTile(tile: tile))
        neighbors.removeAll(where: { $0 == nil })
//        for index in 0...neighbors.count {
//            if let aux = neighbors[index] {
//                neighborsTiles.append(aux)
//            }
//        }
        
        return neighbors
    }
    
//    func getNeightborsTiles(tile: Tile, range: Int) -> [[Tile]] {
//        var neighbors: [[Tile?]] = [[Tile?]]()
//        for area in 0...range {
//            for index in 0...
//        }
//    }
    
//    func testRoundTiles(tile: Tile, range: Int) {
//        var neighbors: [[Tile?]] = [[Tile?]]()
//        var selectedTiles: [Tile?] = [Tile?]()
//        selectedTiles.append(getUpTile(tile: tile))
//        for area in 0...range {
//            for index in 0...range {
//                if let aux: Tile = tile {
//                    var tileC: Tile? = getUpTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getUpRightTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getRightTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getDownRightTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getDownTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getDownLeftTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getLeftTile(tile: aux)
//                    neighbors[area].append(tile)
//                    tileC = getUpLeftTile(tile: aux)
//                    neighbors[area].append(tile)
//                }
//            }
//        }
//    }
    
    func testRoundTiles(tile: Tile) {
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
                    if aux[adjacentTile] != tile && !allTiles.contains(aux[adjacentTile]) {
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

        for index in 0...neighborsAreas.count - 1 {
            for jindex in 0...neighborsAreas[index].count - 1 {
                let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in neighborsAreas[index][jindex]?.shape?.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)})
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
