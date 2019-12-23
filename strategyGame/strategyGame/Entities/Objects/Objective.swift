
import SpriteKit

class Objective: Entity {

    public private(set) var health: Int = 3
    
    init(tile: Tile) {
            super.init(name: "Objective", sprite: SKTexture(imageNamed: "objcB0"), tile: tile)
            let animation = SKAction.animate(with: AnimationHandler.shared.objectiveFrames, timePerFrame: 1/TimeInterval(12))
            self.run(SKAction.repeatForever(animation))
    }
    deinit {
        print("deinit objective")
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
