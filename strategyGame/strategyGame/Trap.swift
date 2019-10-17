//
//  Trap.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 17/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Trap: SKSpriteNode {
    
    var coord: (Int, Int)
    var sprite: SKTexture
    var qntdTurnStunned: Int
    
    init(coord:(Int, Int), sprite: SKTexture, qntdTurnStunned: Int) {
        self.coord = coord
        self.sprite = sprite
        self.qntdTurnStunned = qntdTurnStunned
        super.init(texture: sprite, color: UIColor.clear, size: sprite.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activeTrap() {
        
    }
}

