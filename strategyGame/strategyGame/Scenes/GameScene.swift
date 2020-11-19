import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var grid: Grid!
    var hud: HUD!
    
    var background: SKSpriteNode
    
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
    
    let level: LevelDescription
    
    init(size: CGSize, level: LevelDescription) {
        self.background = SKSpriteNode(imageNamed: "Background")
        self.level = level
        
        super.init(size: size)
        
        self.background.position = CGPoint(x: frame.midX, y: frame.midY)
        self.background.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.background.zPosition = -10
        addChild(background)
    }
    
    override func didMove(to view: SKView) {
        loadSounds()
        playMusic()
        AnimationHandler.shared.awake() // initialize static property
        
        let hCorrectionMultiplier = view.frame.height / 896
        //let wCorrectionMultiplier = view.frame.width / 414
        
        var tileW = view.frame.width/6
        if tileW * 8 > view.frame.height/2 {
            tileW = view.frame.height * 0.07875
        }
        let gridW = tileW * CGFloat(level.width)
        self.grid = Grid(position: CGPoint(x: frame.midX - gridW/2, y: 700 * hCorrectionMultiplier), width: level.width, height: level.height, tileSize: CGSize(width: tileW, height: tileW))
        addChild(grid)
        
        GameManager.shared.awake(grid: grid, scene: self)
        grid.drawGrid(tileSet: level.tileSet)
        
        hud = HUD(rect: view.frame)
        addChild(hud)
        
        if let text = level.tutorialText {
            hud.updateMoveDescription(moveDescription: text)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let location: CGPoint = touch.location(in: self)
            let touchedNodes: [SKNode] = nodes(at: location)
            for node in touchedNodes {
                if let tile = node as? Tile {
                    GameManager.shared.touchTile(tile: tile)
                    hud?.updateCharName(name: tile.character?.name)
                    return
                }
            }
        }
    }
    
    func loadNextTutorial() {
        if let view: SKView = self.view {
            var scene: SKScene
            GameManager.shared.destroy()
            if LevelGenerator.tutorialIndex < LevelGenerator.tutorials.count-1 {
                scene = GameScene(size: view.bounds.size, level: LevelGenerator.nextTutorial())
            } else {
                scene = MainMenuGameScene(size: view.bounds.size)
            }
            
            scene.scaleMode = .aspectFill
                
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        } else {
            fatalError("No SKView for viewController")
        }
    }
    
    func loadEndGameScene() {
        if let view: SKView = self.view {
            var scene: SKScene
            if GameManager.shared.enemies.isEmpty {
                scene = EndGameScene(size: view.bounds.size, resultText: "Victory!")
            } else {
                scene = EndGameScene(size: view.bounds.size, resultText: "You Lose...")
            }
            GameManager.shared.destroy()
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
