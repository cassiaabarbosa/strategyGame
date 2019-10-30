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
    
    override func showAttackOptions() {
        if self.isExausted {
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
    
    override func basicAttack(target: Actor) -> Bool {
        if self.isExausted {
            return false
        }
        guard GameManager.shared.grid != nil else { return false }
        GameManager.shared.scene.cameraSound.run(SKAction.play())
        target.takeDamage(damage: self.damage)
        isExausted = true
        return true
    }
    
    override func showSpecialAttackOptions() {
        if self.isExausted {
            return
        }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: max(grid.gridAspect.0, grid.gridAspect.1))
        for t in tiles {
            if grid.getTilesAround(tile: self.tile).contains(t) { continue }
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.specialAttackHighlightShader
        }
    }
    
    override func specialAttack(toTile: Tile) {
        if self.isExausted {
            return
        }
        func push(character: Actor, to tile: Tile?) {
            if tile == nil { return }
            if tile!.isWalkable {
                character.move(tile: tile!)
            } else if tile!.character != nil {
                character.takeDamage(damage: 1)
                tile!.character?.takeDamage(damage: 1)
            } else if tile!.prop as? Hole != nil {
                character.die()
                GameManager.shared.scene.cairBuracoSound.run(SKAction.play())
            } else if tile!.prop as? Mountain != nil {
                character.takeDamage(damage: 1)
            } else if let trap = tile!.prop as? Trap {
                character.move(tile: tile!)
                trap.activateTrap(character: character)
            } else if tile!.prop as? Objective != nil {
                character.takeDamage(damage: 1)
            } else {
                print("Ranged::push(): prop didn't conform to any Element")
            }
        }
        guard let grid = GameManager.shared.grid else { return }
        // damage target
        if let target = toTile.character {
            target.takeDamage(damage: self.damage)
        }
        // push adjacent tiles
        if let upTarget = grid.getUpTile(tile: toTile)?.character {
            push(character: upTarget, to: grid.getUpTile(tile: upTarget.tile))
        }
        if let downTarget = grid.getDownTile(tile: toTile)?.character {
            push(character: downTarget, to: grid.getDownTile(tile: downTarget.tile))
        }
        if let leftTarget = grid.getLeftTile(tile: toTile)?.character {
            push(character: leftTarget, to: grid.getLeftTile(tile: leftTarget.tile))
        }
        if let rightTarget = grid.getRightTile(tile: toTile)?.character {
            push(character: rightTarget, to: grid.getRightTile(tile: rightTarget.tile))
        }
        grid.removeHighlights()
        isExausted = true
    }
    
}
