import SpriteKit

class Grid: SKNode {

    var tiles: [Tile] = [Tile]()
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
            print("Grid: getTile(): tile out of grid!")
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
