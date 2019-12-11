//
//  CreditGameScene.swift
//  strategyGame
//  Created by Cassia Aparecida Barbosa on 09/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class CreditsGameScene: SKScene {
    
    var background: Background?
    var backButton: BackButton = BackButton(rect: CGRect(x: 120, y: 200, width: 120*buttonScale, height: 39*buttonScale), text: "Back")
    
    let alexsCredits = SKLabelNode(fontNamed: "Copperplate-Bold")
    let antoniosCredits = SKLabelNode(fontNamed: "Copperplate-Bold")
    let artursCredits = SKLabelNode(fontNamed: "Copperplate-Bold")
    let cassiasCredits = SKLabelNode(fontNamed: "Copperplate-Bold")
    let edgarsCredits = SKLabelNode(fontNamed: "Copperplate-Bold")
    let wolfgangsCredits = SKLabelNode(fontNamed: "Copperplate-Bold")
    
    override init(size: CGSize) {
           super.init(size: size)
       }
    
    override func didMove(to view: SKView) {
        self.background = Background(view: view)
        alexsCredits.text = "Alex Nascimento"
        alexsCredits.fontSize = 20
        alexsCredits.fontColor = SKColor.black
        alexsCredits.position = CGPoint(x: frame.midX, y: 600)
        
        antoniosCredits.text = "Antonio Luiz Basile"
        antoniosCredits.fontSize = 20
        antoniosCredits.fontColor = SKColor.black
        antoniosCredits.position = CGPoint(x: frame.midX, y: 550)
        
        artursCredits.text = "Artur Carneiro"
        artursCredits.fontSize = 20
        artursCredits.fontColor = SKColor.black
        artursCredits.position = CGPoint(x: frame.midX, y: 500)
        
        
        cassiasCredits.text = "Cassia Barbosa"
        cassiasCredits.fontSize = 20
        cassiasCredits.fontColor = SKColor.black
        cassiasCredits.position = CGPoint(x: frame.midX, y: 450)
        
        edgarsCredits.text = "Edgar Sgroi"
        edgarsCredits.fontSize = 20
        edgarsCredits.fontColor = SKColor.black
        edgarsCredits.position = CGPoint(x: frame.midX, y: 400)
        
        wolfgangsCredits.text = "Wolfgang Walder"
        wolfgangsCredits.fontSize = 20
        wolfgangsCredits.fontColor = SKColor.black
        wolfgangsCredits.position = CGPoint(x: frame.midX, y: 350)
        
        addChild(background!)
        addChild(backButton)
        addChild(alexsCredits)
        addChild(artursCredits)
        addChild(antoniosCredits)
        addChild(cassiasCredits)
        addChild(edgarsCredits)
        addChild(wolfgangsCredits)
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
                        loadMainMenuGameScene()
                    }
                }
            }
        }
    }
    
    func loadMainMenuGameScene() {
        if let view: SKView = self.view {
            let scene: SKScene = MainMenuGameScene(size: view.bounds.size)
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
