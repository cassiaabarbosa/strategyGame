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
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
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
    
    override func basicAttack(target: Actor) -> Bool {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return false
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
                print("Actor::push(): prop didn't conform to any Element")
            }
        }
        guard let grid = GameManager.shared.grid else { return false }
        switch target.tile {
        case grid.getUpTile(tile: self.tile):
            push(character: target, to: grid.getUpTile(tile: target.tile))
        case grid.getDownTile(tile: self.tile):
            push(character: target, to: grid.getDownTile(tile: target.tile))
        case grid.getLeftTile(tile: self.tile):
            push(character: target, to: grid.getLeftTile(tile: target.tile))
        case grid.getRightTile(tile: self.tile):
            push(character: target, to: grid.getRightTile(tile: target.tile))
        default:
            return false
        }
        GameManager.shared.scene.quackSound.run(SKAction.play())
        target.takeDamage(damage: self.damage)
        isExausted = true
        return true
    }
    
    override func showSpecialAttackOptions() {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
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
    
    override func specialAttack(toTile: Tile) {
        guard let grid = GameManager.shared.grid else { return }
        GameManager.shared.scene.setTrapSound.run(SKAction.play())
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
