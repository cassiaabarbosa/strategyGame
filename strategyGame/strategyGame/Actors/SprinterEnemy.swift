//
//  SprinterEnemy.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class SprinterEmeny: Actor {
    
    init(tile: Tile) {
        super.init(name: "Sprinter", movement: 4, damage: 2, health: 4, attackRange: 1, sprite: SKTexture(imageNamed: "OysterVolcano"), tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
