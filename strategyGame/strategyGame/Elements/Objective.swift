
import SpriteKit

class Objective: Element {
    
    init(tile: Tile) {
        super.init(name: "Objective", sprite: SKTexture(imageNamed: "trap"), tile: tile, qntdTurnStunned: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
