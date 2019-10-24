//
//  PlayButton.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 23/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class PlayButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Play")
    }
    
    override func press() {
        self.pressed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
