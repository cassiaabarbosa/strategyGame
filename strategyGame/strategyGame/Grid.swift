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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
