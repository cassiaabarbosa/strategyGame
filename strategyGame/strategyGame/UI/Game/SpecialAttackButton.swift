//
//  SpecialAttackButton.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 19/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class SpecialAttackButton: Button {
    
    override init(rect: CGRect, text: String, action: @escaping () -> Void) {
        super.init(rect: rect, text: "Special", action: action)
        self.label.position = CGPoint(x: 0, y: -5)
    }
    
    override func press() {
        Button.unpressAll()
        GameManager.shared.onSpecialAttackButtonPress()
        self.pressed = true
    }
    
    override func unpress() {
        GameManager.shared.onSpecialAttackButtonUnpress()
        self.pressed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
