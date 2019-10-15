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
        for i in 0..<amout {
            let row = i / gridAspect.0
            let col = i % gridAspect.0
            let xPos = CGFloat(col) * tileSize.width
            let yPos = CGFloat(row) * tileSize.height * -1
            let tile = Tile(id: i, x: xPos, y: yPos, rectSide: tileSize.width, type: charArray[i])
            print(charArray[i])
            tiles.append(tile)
            addChild(tile)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
