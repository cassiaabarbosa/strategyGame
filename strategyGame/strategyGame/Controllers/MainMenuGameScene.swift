//
//  MainMenuGameScene.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 23/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

let buttonW: CGFloat = 120*CGFloat(buttonScale)
let buttonH: CGFloat = 39*CGFloat(buttonScale)

class MainMenuGameScene: SKScene {
    
    var background: SKSpriteNode?
    var titleTex = SKTexture(imageNamed: "title-1")
    var title: SKSpriteNode
    var playButton: PlayButton = PlayButton(rect: CGRect(x: 120, y: 300, width: buttonW, height: buttonH), text: "Play")
    var settingsButton: SettingsButton = SettingsButton(rect: CGRect(x: 120, y: 200, width: buttonW, height: buttonH), text: "Settings")
    var creditsButton: CreditsButton = CreditsButton(rect: CGRect(x: 120, y: 100, width: buttonW, height: buttonH), text: "Credits")
    var player: SKAudioNode = SKAudioNode()
    var backgroundMusic: SKAudioNode!
    var modal: Modal = Modal(rect: CGRect(x: 500, y: 300, width: 300, height: 300))
    
    override init(size: CGSize) {
        let titleH: CGFloat = 294
        let padding = size.height/16
        title = SKSpriteNode(texture: titleTex, color: .white, size: CGSize(width: size.width, height: titleH))
        title.position = CGPoint(x: size.width/2, y: size.height - titleH/2)
        
        playButton.position = CGPoint(x: size.width/2, y: size.height - titleH - padding*2)
        settingsButton.position = CGPoint(x: size.width/2, y: playButton.position.y - buttonH - padding)
        creditsButton.position = CGPoint(x: size.width/2, y: settingsButton.position.y - buttonH - padding)
        
        modal.position = CGPoint(x: 207, y: 100)
        modal.isHidden = true
        
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        titleTex.filteringMode = .nearest
        self.background = SKSpriteNode(imageNamed: "Background")
        self.background?.position = CGPoint(x: frame.midX, y: frame.midY)
        self.background?.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.background?.zPosition = -10
        self.playMusic()
        addChild(background!)
        addChild(playButton)
        addChild(settingsButton)
        addChild(creditsButton)
        addChild(title)
        addChild(modal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let location: CGPoint = touch.location(in: self)
            let touchedNodes: [SKNode] = nodes(at: location)
            for node in touchedNodes {
                if let playButton: PlayButton = node as? PlayButton {
                    if playButton.pressed {
                        playButton.unpress()
                    } else {
                        playButton.press()
                        loadGameScene()
                    }
                }
                if let settingsButton: SettingsButton = node as? SettingsButton {
                    if settingsButton.pressed {
                        settingsButton.unpress()
                    } else {
                        settingsButton.press()
                        loadModal()
                        playButton.isHidden = true
                        creditsButton.isHidden = true
                        settingsButton.isHidden = true
                    }
                }
                if let creditsButton: CreditsButton = node as? CreditsButton {
                    if creditsButton.pressed {
                        creditsButton.unpress()
                    } else {
                        creditsButton.press()
                        loadCreditsGameScene()
                    }
                }
            }
        }
    }
            
    func loadGameScene() {
        if let view: SKView = self.view {
            // Load the SKScene from 'GameScene.sks'
            let scene: SKScene = GameScene(size: view.bounds.size)
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
    
    func loadCreditsGameScene() {
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
    
    func loadModal() {
        modal.isHidden = false
    }
       
    func playMusic() {
        if let musicURL = Bundle.main.url(forResource: "calma", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }
}
