//
//  HealthBar.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 24/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class HealthBar: SKSpriteNode {
    
    var normalTex = SKTexture(imageNamed: "healthbar")
    var label: SKLabelNode
    
    init(rect: CGRect, text: String) {
        self.label = SKLabelNode(text: text)
        super.init(texture: normalTex, color: .white, size: rect.size)
        self.position = CGPoint(x: rect.maxX - rect.width/2, y: rect.maxY - rect.height/2)
        self.label.position = CGPoint(x: 0, y: -8)
        self.label.fontSize = 30*(rect.size.height/39)
        self.label.fontColor = .black
        self.label.zPosition = 1.0
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
