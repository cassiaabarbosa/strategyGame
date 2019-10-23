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
        super.init(name: "Melee", movement: 2, damage: 2, health: 4, attackRange: 1, sprite: SKTexture(imageNamed: "00_melee"), tile: tile)
        let animation = SKAction.animate(with: AnimationHandler.shared.meleeFrames, timePerFrame: 1/TimeInterval(6))
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
