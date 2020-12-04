//
//  MainMenuGameScene.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 23/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class MainMenuGameScene: SKScene {
    
    var gameScene: GameScene?
    var background: SKSpriteNode?
    var titleTex = SKTexture(imageNamed: "title-1")
    var title: SKSpriteNode
    var playButton: PlayButton = PlayButton(rect: CGRect(x: 120, y: 300, width: 120*buttonScale, height: 39*buttonScale), text: "Play")
    var settingsButton: SettingsButton = SettingsButton(rect: CGRect(x: 120, y: 200, width: 120*buttonScale, height: 39*buttonScale), text: "Settings")
    var creditsButton: CreditsButton = CreditsButton(rect: CGRect(x: 120, y: 100, width: 120*buttonScale, height: 39*buttonScale), text: "Credits")
    var player: SKAudioNode = SKAudioNode()
    var backgroundMusic: SKAudioNode!
    var modal: Modal = Modal(rect: CGRect(x: 100, y: 100, width: 200, height: 200))
    var musicButton: MusicButton = MusicButton(rect: CGRect(x: 100, y: 200, width: 20*buttonScale, height: 20*buttonScale), text: "")
    
    var sfxButton: AudioButton = AudioButton(rect: CGRect(x: 100, y: 100, width: 20*buttonScale, height: 20*buttonScale), text: "")
    
    override init(size: CGSize) {
        title = SKSpriteNode(texture: titleTex, color: .white, size: CGSize(width: size.width, height: 294.4))
        
        title.position = CGPoint(x: 207, y: 600)
        
        super.init(size: size)
        modal.position = CGPoint(x: frame.midX, y: (frame.midY)*0.5)
        modal.isHidden = true
        musicButton.isHidden = true
        sfxButton.isHidden = true
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
        addChild(sfxButton)
        addChild(musicButton)
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
                        musicButton.isHidden = false
                        sfxButton.isHidden = false
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
                
                if let musicButton: MusicButton = node as? MusicButton {
                    if musicButton.pressed {
                        musicButton.unpress()
                        backgroundMusic.run(SKAction.play())
                        gameScene?.run(SKAction.play())
                        musicButton.texture = SKTexture(imageNamed: "MusicButton")
                        
                    } else {
                        musicButton.texture = SKTexture(imageNamed: "MusicMutedButtonPressed")
                        backgroundMusic.run(SKAction.stop())
                    }
                }
//                if let modal: Modal = node as? Modal {
//                    if musicButton.pressed {
//                        musicButton.unpress()
//                    } else {
//                        musicButton.press()
//                        musicButton.texture = SKTexture(imageNamed: "MusicMutedButtonPressed")
//                        backgroundMusic.run(SKAction.stop())
//                    }
//
//                    if sfxButton.pressed {
//                        sfxButton.unpress()
//                    } else {
//                        sfxButton.press()
//                        sfxButton.texture = SKTexture(imageNamed: "SoundMutedButtonPressed")
//                        gameScene?.canoSound.run(SKAction.stop())
//                        gameScene?.quackSound.run(SKAction.stop())
//                        gameScene?.cameraSound.run(SKAction.stop())
//                        gameScene?.setTrapSound.run(SKAction.stop())
//                        gameScene?.hitWallSound.run(SKAction.stop())
//                        gameScene?.cairBuracoSound.run(SKAction.stop())
//
//                    }
//                }
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
