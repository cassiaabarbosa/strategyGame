//
//  HeavyEnemy.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class HeavyEnemy: Actor {
    
    init(tile: Tile) {
        super.init(name: "Heavy", movement: 3, damage: 1, health: 4, attackRange: 1, sprite: SKTexture(imageNamed: "OysterVolcano"), tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
