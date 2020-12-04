//
//  SpecialAttackButton.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 19/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class SpecialAttackButton: Button {
    
    init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Special",
                   action: {
                    Button.unpressAll()
                    GameManager.shared.onSpecialAttackButtonPress()
                   },
                   unToggle: {
                    GameManager.shared.onSpecialAttackButtonUnpress()
                   })
        self.label.position = CGPoint(x: 0, y: -5)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
