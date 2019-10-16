import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var grid: Grid?
    
    var templateSceneString: String = """
000000\
111111\
222222\
333333\
444444\
555555\
666666\
777777
"""
    
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        let position = CGPoint(x: 30, y: 700)
        let size = CGSize(width: 60, height: 60)
        self.grid = Grid(position: position, width: 6, height: 8, tileSize: size)
        grid?.drawGrid(tileSet: templateSceneString)
        addChild(grid!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
