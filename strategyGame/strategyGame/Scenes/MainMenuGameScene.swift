//
//  MainMenuGameScene.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 23/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class MainMenuGameScene: SKScene {
    
    var background: SKSpriteNode
    var titleTex: SKTexture
    var title: SKSpriteNode
    var player: SKAudioNode = SKAudioNode()
    var backgroundMusic: SKAudioNode!
    
    lazy var playButton = Button(rect: CGRect(x: 120, y: 300, width: 120*buttonScale, height: 39*buttonScale),
                                 text: "Play",
                                 action: { [weak self] in
                                    self?.loadGameScene()
                                 })
    
    lazy var tutorialButton = Button(rect: CGRect(x: 120, y: 200, width: 120*buttonScale, height: 39*buttonScale),
                                     text: "Tutorial",
                                     action: { [weak self] in
                                        self?.loadTutorialScene()
                                     })
    
    lazy var creditsButton = Button(rect: CGRect(x: 120, y: 100, width: 120*buttonScale, height: 39*buttonScale),
                                    text: "Credits",
                                    action: { [weak self] in
                                        self?.loadCreditsScene()
                                    })
    
    override init(size: CGSize) {
        background = SKSpriteNode(imageNamed: "Background")
        titleTex = SKTexture(imageNamed: "title-1")
        title = SKSpriteNode(texture: titleTex, color: .white, size: CGSize(width: size.width, height: 294.4))
        
        super.init(size: size)
        
        self.background.position = CGPoint(x: frame.midX, y: frame.midY)
        self.background.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.background.zPosition = -10
        titleTex.filteringMode = .nearest
        title.position = CGPoint(x: 207, y: 600)
    }
    
    override func didMove(to view: SKView) {
        
        self.playMusic()
        addChild(background)
        addChild(playButton)
        addChild(tutorialButton)
        addChild(creditsButton)
        addChild(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
            
    func loadGameScene() {
        if let view: SKView = self.view {
            let scene: SKScene = GameScene(size: view.bounds.size, level: LevelGenerator.randomLevel())
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
    
    func loadTutorialScene() {
        if let view: SKView = self.view {
            let scene: SKScene = GameScene(size: view.bounds.size, level: LevelGenerator.tutorial1)
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
    
    func loadCreditsScene() {
        if let view: SKView = self.view {
            let scene: SKScene = CreditsGameScene(size: view.bounds.size)
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
        if let musicURL = Bundle.main.url(forResource: "calma", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }
}
