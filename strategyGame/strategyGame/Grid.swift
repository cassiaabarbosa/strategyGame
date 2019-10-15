import SpriteKit

class Grid : SKNode {

    var tiles = [Tile]()
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
        let charArray = Array(tileSet)
        let amout = gridAspect.0 * gridAspect.1
        for id in 0..<amout {
            let row = id / gridAspect.0
            let col = id % gridAspect.0
            let xPos = CGFloat(col) * tileSize.width
            let yPos = CGFloat(row) * tileSize.height * -1
            let tile = Tile(id: id, positionX: xPos, positionY: yPos, rectSide: tileSize.width, type: charArray[id])
            print(charArray[id])
            tiles.append(tile)
            addChild(tile)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
