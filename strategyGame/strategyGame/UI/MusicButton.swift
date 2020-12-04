//
//  MusicButton.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 26/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class MusicButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: " ")
    }
    
    override func press() {
        self.pressed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
