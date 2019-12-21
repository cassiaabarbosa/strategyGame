import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var grid: Grid?
    var background: SKSpriteNode?
    var hud: HUD?
    var backgroundMusic: SKAudioNode!
    var quackSound: SKAudioNode!
    var glassBreak: SKAudioNode!
    var cairBuracoSound: SKAudioNode!
    var canoSound: SKAudioNode!
    var cameraSound: SKAudioNode!
    var setTrapSound: SKAudioNode!
    var hitWallSound: SKAudioNode!
    
    var templateSceneString: String = """
..v...\
....m.\
.c....\
m..m.s\
.h..T.\
mM..h.\
.lRh..\
......
"""
    
//    var templateSceneString: String = """
//    .vm...\
//    h...c.\
//    ......\
//    ..mm..\
//    .M.v..\
//    .h..m.\
//    ..T.R.\
//    mm....
//    """
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        loadSounds()
        playMusic()
        AnimationHandler.shared.awake()
        self.background = SKSpriteNode(imageNamed: "Background")
        self.background?.position = CGPoint(x: frame.midX, y: frame.midY)
        self.background?.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.background?.zPosition = -10
        addChild(background!)
        self.grid = Grid(position: CGPoint(x: 0, y: 700), width: 6, height: 8, tileSize: CGSize(width: 70, height: 70))
        addChild(grid!)
        GameManager.shared.awake(grid: grid!, scene: self)
        grid?.drawGrid(tileSet: templateSceneString)
        hud = HUD(rect: view.frame)
        addChild(hud!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let location: CGPoint = touch.location(in: self)
            let touchedNodes: [SKNode] = nodes(at: location)
            for node in touchedNodes {
                if let tile: Tile = node as? Tile {
                    GameManager.shared.touchTile(tile: tile)
                    return
                }
                if let button: Button = node as? Button {
                    if button.pressed {
                        button.unpress()
                    } else {
                        button.press()
                        
                        if GameManager.shared.players.isEmpty || GameManager.shared.enemies.isEmpty {
                            loadEndGameScene()
                        }
                    }
                }
            }
        }
    }
    
    func loadEndGameScene() {
        if let view: SKView = self.view {
            // Load the SKScene from 'GameScene.sks'
            var scene: SKScene
            if GameManager.shared.enemies.isEmpty {
                scene = EndGameScene(size: view.bounds.size, resultText: "Victory!")
            } else {
                scene = EndGameScene(size: view.bounds.size, resultText: "You Lose...")
            }
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
                // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        } else {
            fatalError("No SKView for viewController")
        }
    }
    
    func playMusic() {
        if let musicURL = Bundle.main.url(forResource: "agitada", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }
    
    func loadSounds() {
        if let quackURL = Bundle.main.url(forResource: "quack", withExtension: "wav") {
            self.quackSound = SKAudioNode(url: quackURL)
            self.quackSound.autoplayLooped = false
            addChild(quackSound)
        }
        
        if let glassURL = Bundle.main.url(forResource: "glassBreaking", withExtension: "mp3") {
            self.glassBreak = SKAudioNode(url: glassURL)
            self.glassBreak.autoplayLooped = false
            addChild(glassBreak)
        }
        
        if let cairBuracoURL = Bundle.main.url(forResource: "cair-buraco", withExtension: "mp3") {
            self.cairBuracoSound = SKAudioNode(url: cairBuracoURL)
            self.cairBuracoSound.autoplayLooped = false
            addChild(cairBuracoSound)
        }
        
        if let canoURL = Bundle.main.url(forResource: "cano", withExtension: "mp3") {
            self.canoSound = SKAudioNode(url: canoURL)
            self.canoSound.autoplayLooped = false
            addChild(canoSound)
        }
        
        if let cameraURL = Bundle.main.url(forResource: "camera-shutter-click-01", withExtension: "mp3") {
            self.cameraSound = SKAudioNode(url: cameraURL)
            self.cameraSound.autoplayLooped = false
            addChild(cameraSound)
        }
        
        if let trapURL = Bundle.main.url(forResource: "setTrap", withExtension: "mp3") {
            self.setTrapSound = SKAudioNode(url: trapURL)
            self.setTrapSound.autoplayLooped = false
            addChild(setTrapSound)
        }
        
        if let hitWallURL = Bundle.main.url(forResource: "HitWall", withExtension: "mp3") {
            self.hitWallSound = SKAudioNode(url: hitWallURL)
            self.hitWallSound.autoplayLooped = false
            addChild(hitWallSound)
        }
    }
}
