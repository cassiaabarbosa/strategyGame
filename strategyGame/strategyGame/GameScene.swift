import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var grid: Grid?
    var players: [Actor]?
    
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
    var templateSceneString2: String = """
00000\
11111\
22222\
33333\
44444\
55555\
66666\
77777\
88888\
99999\
00000\
11111
"""
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        let position: CGPoint = CGPoint(x: 5, y: 800)
        let size: CGSize = CGSize(width: 80, height: 80)
        self.grid = Grid(position: position, width: 5, height: 11, tileSize: size)
        grid?.drawGrid(tileSet: templateSceneString2)
        addChild(grid!)
        GameManager.shared.setActorsOnGrid(gameScene: self, grid: grid!)
        GameManager.shared.grid = grid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            switch GameManager.shared.turnPhase {
            case .playerMove:
                let location: CGPoint = touch.location(in: self)
                let touchedNodes: [SKNode] = nodes(at: location)
                for node in touchedNodes {
                    if let actor: Actor = node as? Actor {
                        GameManager.shared.currentCharacter = actor as? Melee
                        GameManager.shared.showTilesPath()
                        return
                    }
                    if let tile: Tile = node as? Tile {
                        if GameManager.shared.currentCharacter != nil {
                            GameManager.shared.makeAMovement(tile: tile)
                        }
                    }
                }
            case .enemyMove:
                return
            }
        }
    }
}
