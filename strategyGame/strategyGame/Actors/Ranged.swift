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
    
    init(tile: Tile) {
    super.init(name: "Ranged", movement: 3, damage: 1, health: 3, attackRange: 3, sprite: SKTexture(imageNamed: "OysterVolcano"), tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func specialAttack() {
        
    }
}
