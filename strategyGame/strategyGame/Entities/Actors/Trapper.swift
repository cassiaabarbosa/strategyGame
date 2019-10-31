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
    
    override func showAttackOptions() {
        if self.isExausted { return }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: 2)
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.attackHighlightShader
        }
    }
    
    // attack should be verified in showAttackOptions(). if it highlights it is clickable
    override func basicAttack(tile: Tile) {
        GameManager.shared.scene.quackSound.run(SKAction.play())
        tile.character?.takeDamage(damage: self.damage)
        
        guard let grid = GameManager.shared.grid else { return }
        switch grid.getDirection(from: self.tile, to: tile) {
        case 0:
            tile.push(direction: 0)
        case 1:
            tile.push(direction: 1)
        case 2:
            tile.push(direction: 2)
        case 3:
            tile.push(direction: 3)
        default:
            print("Trapper::basicAttack(): switch exausted!")
            return
        }
        isExausted = true
    }
    
    override func showSpecialAttackOptions() {
        if self.isExausted { return }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: 1)
        for t in tiles {
            if t.isEmpty && !t.isOcupied {
                grid.ableTiles.append(t)
            }
        }
        for t in grid.ableTiles {
            t.isSpecialHighlighted = true
        }
    }
    
    override func specialAttack(tile: Tile) {
        guard let grid = GameManager.shared.grid else { return }
        GameManager.shared.scene.setTrapSound.run(SKAction.play())
        if (tile.isSpecialHighlighted == true) {
            if (trapNumber > 0) {
                trapNumber -= 1
                let trap = Trap(tile: grid.tiles[tile.id])
                tile.prop = trap
                grid.addChild(trap)

            }
        }
        self.isExausted = true
    }
}
