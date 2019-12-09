//
//  SpecialAttackButton.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 19/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class SpecialAttackButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Special Attack")
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
