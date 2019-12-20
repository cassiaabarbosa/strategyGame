//
//  MainMenuGameScene.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 23/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class MainMenuGameScene: SKScene {
    
    var background: Background?
    var titleTex = SKTexture(imageNamed: "title")
    var title: SKSpriteNode
    var playButton: PlayButton = PlayButton(rect: CGRect(x: 120, y: 300, width: 120*buttonScale, height: 39*buttonScale), text: "Play")
    var settingsButton: SettingsButton = SettingsButton(rect: CGRect(x: 120, y: 200, width: 120*buttonScale, height: 39*buttonScale), text: "Settings")
    var creditsButton: CreditsButton = CreditsButton(rect: CGRect(x: 120, y: 100, width: 120*buttonScale, height: 39*buttonScale), text: "Credits")
    var player: SKAudioNode = SKAudioNode()
    var backgroundMusic: SKAudioNode!
    var modal: Modal = Modal(rect: CGRect(x: 500, y: 300, width: 300, height: 300))
    
    override init(size: CGSize) {
        title = SKSpriteNode(texture: titleTex, color: .white, size: CGSize(width: size.width, height: 294.4))
        
        title.position = CGPoint(x: 207, y: 600)
        
        modal.position = CGPoint(x: 207, y: 100)
        modal.isHidden = true
        
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        self.background = Background(view: view)
        //self.playMusic()
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
