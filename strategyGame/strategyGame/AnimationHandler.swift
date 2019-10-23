import SpriteKit

class AnimationHandler {
    
    static let shared = AnimationHandler()
    var meleeAtlas: SKTextureAtlas
    var meleeFrames: [SKTexture]
    var rangedAtlas: SKTextureAtlas
    var rangedFrames: [SKTexture]
    var trapperAtlas: SKTextureAtlas
    var trapperFrames: [SKTexture]
    var clamAtlas: SKTextureAtlas
    var clamFrames: [SKTexture]
    
    private init() {
        self.meleeAtlas = SKTextureAtlas(named: "MeleeAtlas")
        self.meleeFrames = AnimationHandler.loadFrames(atlas: meleeAtlas)
        self.rangedAtlas = SKTextureAtlas(named: "RangedAtlas")
        self.rangedFrames = AnimationHandler.loadFrames(atlas: rangedAtlas)
        self.trapperAtlas = SKTextureAtlas(named: "TrapperAtlas")
        self.trapperFrames = AnimationHandler.loadFrames(atlas: trapperAtlas)
        self.clamAtlas = SKTextureAtlas(named: "ClamAtlas")
        self.clamFrames = AnimationHandler.loadFrames(atlas: clamAtlas)
        
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
