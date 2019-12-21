//
//  TextBox.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 20/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class TextBox: SKSpriteNode {
    var textLabel: SKLabelNode
    
    init(rect: CGRect) {
        self.textLabel = SKLabelNode()
        super.init(texture: nil, color: UIColor(cgColor: CGColor(srgbRed: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)), size: rect.size)
        addChild(textLabel)
        self.textLabel.zPosition = 1
        self.textLabel.position = CGPoint(x: frame.midX, y: frame.midY-7.5)
        self.textLabel.fontSize = 18
        self.textLabel.fontColor = #colorLiteral(red: 0.2803396583, green: 0.2141204476, blue: 0.1477846205, alpha: 1)
        self.textLabel.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
