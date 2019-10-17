import SpriteKit

class Grid: SKNode {

    var tiles: [Tile] = [Tile]()
    let tileSize: CGSize
    let gridAspect: (Int, Int) // width, height
    var tileSet: String?
    
    init(position: CGPoint, width: Int, height: Int, tileSize: CGSize) {
        self.tileSize = tileSize
        self.gridAspect = (width, height)
        super.init()
        self.position = position
    }
    
    func drawGrid(tileSet: String) {
        let charArray: [String.Element] = Array(tileSet)
        let amout: Int = gridAspect.0 * gridAspect.1
        for id in 0..<amout {
            let row: Int = id / gridAspect.0
            let col: Int = id % gridAspect.0
            let xPos: CGFloat = CGFloat(col) * tileSize.width
            let yPos: CGFloat = CGFloat(row) * tileSize.height * -1
            let tile: Tile = Tile(id: id, positionX: xPos, positionY: yPos, rectSide: tileSize.width, type: charArray[id])
            tiles.append(tile)
            addChild(tile)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
