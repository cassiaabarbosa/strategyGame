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
    var specialAttackButton: SpecialAttackButton?
   
    init(tile: Tile) {
        super.init(name: "Trapper", movement: 4, damage: 1, health: 3, attackRange: 1, sprite: SKTexture(imageNamed: "00_trapper"), tile: tile)
        let animation = SKAction.animate(with: AnimationHandler.shared.trapperFrames, timePerFrame: 1/TimeInterval(6))
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func specialAttack(toTile: Tile) {
        guard let grid = GameManager.shared.grid else { return }
        if (toTile.isSpecialHighlighted == true) {
            if (trapNumber > 0) {
                trapNumber -= 1
                let trap = Trap(tile: grid.tiles[toTile.id])
                toTile.prop = trap
                grid.addChild(trap)

            }
        }
        self.isExausted = true
    }
}
