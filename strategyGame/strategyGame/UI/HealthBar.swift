//
//  HealthBar.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 24/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class HealthBar: SKSpriteNode {
    var normalTex = SKTexture(imageNamed: "ButtonNormal")
    
    var label: SKLabelNode
    
    init(rect: CGRect, text: String) {
        self.label = SKLabelNode(text: text)
        super.init(texture: normalTex, color: .white, size: rect.size)
        self.position = CGPoint(x: rect.maxX - rect.width/2, y: rect.maxY - rect.height/2)
        self.label.position = CGPoint(x: 0, y: -10)
        self.label.fontSize = self.label.text!.count < 10 ? 23*(rect.size.height/39) : 17.5*(rect.size.height/39)
        self.label.fontColor = .black
        self.label.zPosition = 1.0
        addChild(label)
    }
    
    deinit {
        for i in (0..<Button.buttonList.count) where self == Button.buttonList[i] {
            Button.buttonList.remove(at: i)
        }
    }
    
    func press() {}
    
    func unpress() {}
    
    static func unpressAll() {
        for i in (0..<Button.buttonList.count) {
            Button.buttonList[i].pressed = false
        }
        GameManager.shared.OnAttackButtonUnpress()
        GameManager.shared.OnSpecialAttackButtonUnpress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
