import SpriteKit

class AnimationHandler {
    
    static let shared = AnimationHandler()
    var meleeAtlas: SKTextureAtlas
    var meleeFrames: [SKTexture]
    var rangedAtlas: SKTextureAtlas
    var rangedFrames: [SKTexture]
    var trapperAtlas: SKTextureAtlas
    var trapperFrames: [SKTexture]
    var holeAtlas: SKTextureAtlas
    var holeFrames: [SKTexture]
    var mountainAtlas: SKTextureAtlas
    var mountainFrames: [SKTexture]
    
    private init() {
        self.meleeAtlas = SKTextureAtlas(named: "MeleeAtlas")
        self.meleeFrames = AnimationHandler.loadFrames(atlas: meleeAtlas)
        self.rangedAtlas = SKTextureAtlas(named: "RangedAtlas")
        self.rangedFrames = AnimationHandler.loadFrames(atlas: rangedAtlas)
        self.trapperAtlas = SKTextureAtlas(named: "TrapperAtlas")
        self.trapperFrames = AnimationHandler.loadFrames(atlas: trapperAtlas)
        self.holeAtlas = SKTextureAtlas(named: "HoleAtlas")
        self.holeFrames = AnimationHandler.loadFrames(atlas: holeAtlas)
        self.mountainAtlas = SKTextureAtlas(named: "MountainAtlas")
        self.mountainFrames = AnimationHandler.loadFrames(atlas: mountainAtlas)
    }
    
    func awake() {}
    
    static func loadFrames(atlas: SKTextureAtlas) -> [SKTexture] {
        var frames = [SKTexture]()
        let names = atlas.textureNames.sorted()

        for i in 0..<names.count {
            let texture = atlas.textureNamed(names[i])
            texture.filteringMode = .nearest
            frames.append(texture)
        }

        return frames
    }

}
