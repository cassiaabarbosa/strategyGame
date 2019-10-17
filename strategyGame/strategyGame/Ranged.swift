//
//  Ranged.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Ranged: Actor {
    
    override init(name: String, movement: Int, coord: (Int, Int), sprite: SKTexture, state: State, damage: Int, health: Int, attackRange: Int) {
        super.init(name: name, movement: movement, coord: coord, sprite: sprite, state: state, damage: damage, health: health, attackRange: attackRange)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func specialAttack() {
        
    }
}
