//
//  EndGameScene.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 24/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class EndGameScene: SKScene {
    
    var background: Background?
    var resultLabel: SKLabelNode
    var playAgainButton: PlayButton = PlayButton(rect: CGRect(x: 120, y: 200, width: 107*buttonScale, height: 39*buttonScale), text: "Play again")
    
    init(size: CGSize, resultText: String) {
        resultLabel = SKLabelNode(text: resultText)
        resultLabel.position = CGPoint(x: 207, y: 500)
        resultLabel.fontSize = 60
        resultLabel.fontColor = .black
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        self.background = Background(view: view)
        addChild(background!)
        addChild(playAgainButton)
        addChild(resultLabel)
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
}
