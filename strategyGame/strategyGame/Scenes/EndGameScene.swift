//
//  EndGameScene.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 24/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class EndGameScene: SKScene {
    
    var background: SKSpriteNode?
    var resultLabel: SKLabelNode
    var playAgainButton: Button = Button(rect: CGRect(x: 120, y: 200, width: 120*buttonScale, height: 39*buttonScale), text: "Continue")
    var backgroundMusic: SKAudioNode!
    
    init(size: CGSize, resultText: String) {
        resultLabel = SKLabelNode(text: resultText)
        resultLabel.position = CGPoint(x: 207, y: 500)
        resultLabel.fontSize = 60
        resultLabel.fontColor = .black
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(imageNamed: "Background")
        self.background?.position = CGPoint(x: frame.midX, y: frame.midY)
        self.background?.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.background?.zPosition = -10
        addChild(background!)
        addChild(playAgainButton)
        addChild(resultLabel)
        playMusic()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let location: CGPoint = touch.location(in: self)
            let touchedNodes: [SKNode] = nodes(at: location)
            for node in touchedNodes {
                if let button: Button = node as? Button {
                    if button.pressed {
                        button.unpress()
                    } else {
                        button.press()
                        loadGameScene()
                    }
                }
            }
        }
    }
    
    func loadGameScene() {
        if let view: SKView = self.view {
            let scene: SKScene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
                
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        } else {
            fatalError("No SKView for viewController")
        }
    }
    
    func playMusic() {
        if resultLabel.text == "Victory!" {
            if let musicURL = Bundle.main.url(forResource: "win", withExtension: "mp3") {
                backgroundMusic = SKAudioNode(url: musicURL)
                backgroundMusic.autoplayLooped = false
                addChild(backgroundMusic)
            }
        } else {
            if let musicURL = Bundle.main.url(forResource: "terceiraTrilha", withExtension: "mp3") {
                backgroundMusic = SKAudioNode(url: musicURL)
                backgroundMusic.autoplayLooped = false
                addChild(backgroundMusic)
            }
        }
    }
}
