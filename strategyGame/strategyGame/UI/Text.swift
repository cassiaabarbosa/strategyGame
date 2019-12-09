//
//  Text.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 08/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class Text: SKSpriteNode {
    
    var label: SKLabelNode
    
    init(rect: CGRect, text: String) {
        self.label  = SKLabelNode(text: text)
        super.init(texture: .none, color: .black, size: rect.size)
        self.position = CGPoint(x: rect.maxX - rect.width/2, y: rect.maxY - rect.height/2)
        self.label.position = CGPoint(x: 0, y: -10)
        self.label.fontSize = self.label.text!.count < 10 ? 23*(rect.size.height/39) : 17.5*(rect.size.height/39)
        self.label.fontColor = .black
        self.label.zPosition = 1.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
