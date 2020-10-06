//
//  AudioButton.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 08/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class AudioButton: Button {
    
    override init(rect: CGRect, text: String, action:  @escaping () -> Void) {
        super.init(rect: rect, text: " ", action: action)
    }
    
    override func press() {
        self.pressed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
