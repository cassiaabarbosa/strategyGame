
import SpriteKit

enum ObjectiveType {
    case sun
    case moon
}

class Objective: Entity {

    public private(set) var health: Int = 3
    
    init(tile: Tile, type: ObjectiveType) {
        switch type {
        case .sun:
            super.init(name: "Sun", sprite: SKTexture(imageNamed: "00_sun"), tile: tile)
            let animation = SKAction.animate(with: AnimationHandler.shared.sunFrames, timePerFrame: 1/TimeInterval(12))
            self.run(SKAction.repeatForever(animation))
        case .moon:
            super.init(name: "Moon", sprite: SKTexture(imageNamed: "00_moons"), tile: tile)
            let animation = SKAction.animate(with: AnimationHandler.shared.moonFrames, timePerFrame: 1/TimeInterval(8))
            self.run(SKAction.repeatForever(animation))
        }
    }
    
    func takeDamage() {
        self.health -= 1
        if health == 0 {
            self.destroy()
        }
        HUD.updateHealthBars()
    }
    
    func destroy() {
        GameManager.shared.removeSelf(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
