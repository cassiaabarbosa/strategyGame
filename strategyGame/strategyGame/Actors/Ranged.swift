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
    super.init(name: "Ranged", movement: 3, damage: 1, health: 3, attackRange: 3, sprite: SKTexture(imageNamed: "00_ranged"), tile: tile)
        let animation = SKAction.animate(with: AnimationHandler.shared.rangedFrames, timePerFrame: 1/TimeInterval(6))
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func basicAttack(target: Actor) -> Bool {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return false
        }
        guard GameManager.shared.grid != nil else { return false }
        target.takeDamage(damage: self.damage)
        isExausted = true
        return true
    }
    
    override func showAttackOptions() {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: max(grid.gridAspect.0, grid.gridAspect.1))
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.attackHighlightShader
        }
    }
}
