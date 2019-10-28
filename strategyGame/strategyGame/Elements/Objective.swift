
import SpriteKit

enum ObjectiveType {
    case sun
    case moon
}

class Objective: Element {

    public private(set) var hp: Int = 3
    
    init(tile: Tile, type: ObjectiveType) {
        switch type {
        case .sun:
            super.init(name: "Sun", sprite: SKTexture(imageNamed: "00_sun"), tile: tile, qntdTurnStunned: 0)
            let animation = SKAction.animate(with: AnimationHandler.shared.sunFrames, timePerFrame: 1/TimeInterval(12))
            self.run(SKAction.repeatForever(animation))
        case .moon:
            super.init(name: "Moon", sprite: SKTexture(imageNamed: "00_moons"), tile: tile, qntdTurnStunned: 0)
            let animation = SKAction.animate(with: AnimationHandler.shared.moonFrames, timePerFrame: 1/TimeInterval(8))
            self.run(SKAction.repeatForever(animation))
        }
    }
    
    func takeDamage() {
        self.hp -= 1
        if hp == 0 {
            self.destroy()
        }
    }
    
    func destroy() {
        if let index = GameManager.shared.objectives.firstIndex(of: self) {
            GameManager.shared.objectives.remove(at: index)
        } else {
            print("Objective::destroy(): index of objective returned nil")
        }
        self.removeFromParent()
        self.tile.prop = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
