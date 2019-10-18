//
//  Melee.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Melee: Actor {
    
    init(tile: Tile) {
        super.init(name: "Melee", movement: 2, damage: 2, health: 4, attackRange: 1, sprite: SKTexture(imageNamed: "Melee-1"), tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func specialAttack() {
        
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let location = touch.location(in: self)
//            self.position = CGPoint(x: location.x, y: location.y)
//        }
//    }
}
