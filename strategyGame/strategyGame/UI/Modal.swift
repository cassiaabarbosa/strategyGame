//
//  Modal.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 08/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class Modal: SKSpriteNode {
    
    var backgroundTex = SKTexture(imageNamed: "Modal")
    var musicLabel: SKLabelNode
    var sfxLabel: SKLabelNode
    
    var musicButton: AudioButton = AudioButton(rect: CGRect(x: 100, y: 200, width: 107*buttonScale, height: 39*buttonScale), text: "")
    
    var sfxButton: AudioButton = AudioButton(rect: CGRect(x: 100, y: 100, width: 107*buttonScale, height: 39*buttonScale), text: "")
    
    init(rect: CGRect) {
        self.sfxLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
        self.musicLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
        super.init(texture: backgroundTex, color: .red, size: rect.size)
        self.position = CGPoint(x: frame.midX, y: frame.midY)
        self.zPosition = 2
        self.musicLabel.fontSize = 16
        self.musicLabel.color = .black
        self.musicLabel.text = "Music"
        self.sfxLabel.fontSize = 16
        self.sfxLabel.color = .black
        self.sfxLabel.text = "Sounds Effects"
        
        addChild(musicLabel)
        addChild(sfxLabel)
        addChild(sfxButton)
        addChild(musicButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
