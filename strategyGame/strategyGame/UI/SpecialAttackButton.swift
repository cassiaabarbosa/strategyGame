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
        self.label.fontSize = 17.5
    }
    
    override func press() {
        if self.pressed {
            GameManager.shared.mode = .move
            self.pressed = false
        } else {
        GameManager.shared.mode = .specialAttack
            self.pressed = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
