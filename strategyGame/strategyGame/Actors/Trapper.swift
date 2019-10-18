//
//  Trapper.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Trapper: Actor {
    var trapNumber: Int = 3
    
    init(tile: Tile) {
        super.init(name: "Trapper", movement: 4, damage: 1, health: 3, attackRange: 1, sprite: SKTexture(imageNamed: "OysterVolcano"), tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func specialAttack() {
    }
    
    func throwTrap() {
        if (trapNumber > 0) {
            
        }
    }
}
