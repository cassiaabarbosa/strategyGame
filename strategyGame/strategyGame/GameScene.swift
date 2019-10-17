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
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        let position: CGPoint = CGPoint(x: 30, y: 700)
        let size: CGSize = CGSize(width: 60, height: 60)
        self.grid = Grid(position: position, width: 6, height: 8, tileSize: size)
        grid?.drawGrid(tileSet: templateSceneString)
        addChild(grid!)
        GameManager.shared.setActorsOnGrid(gameScene: self, grid: grid!)
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
                            GameManager.shared.showTilesPath(grid: grid)
                            return
                        }
                        if let tile: Tile = node as? Tile {
                            if GameManager.shared.currentCharacter != nil {
                                GameManager.shared.makeAMovement(tile: tile)
                            }
                        }
                    }
            }
        }
    }
}
