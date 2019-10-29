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
    
    override func showAttackOptions() {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile)
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
        for i in 0...3 {
            var lastTile: Tile = self.tile
            var limitFound = false
            while !limitFound {
                switch i {
                case 0:
                    if let tile = grid.getUpTile(tile: lastTile) {
                        if tile.isOcupied || !tile.isEmpty {
                            limitFound = true
                        }
                        lastTile = tile
                    } else {
                        limitFound = true
                    }
                case 1:
                    if let tile = grid.getDownTile(tile: lastTile) {
                        if tile.isOcupied || !tile.isEmpty {
                            limitFound = true
                        }
                        lastTile = tile
                    } else {
                        limitFound = true
                    }
                case 2:
                    if let tile = grid.getLeftTile(tile: lastTile) {
                        if tile.isOcupied || !tile.isEmpty {
                            limitFound = true
                        }
                        lastTile = tile
                    } else {
                        limitFound = true
                    }
                case 3:
                    if let tile = grid.getRightTile(tile: lastTile) {
                        if tile.isOcupied || !tile.isEmpty {
                            limitFound = true
                        }
                        lastTile = tile
                    } else {
                        limitFound = true
                    }
                default:
                    fatalError("Melee::showSpecialAttackOptions() exausted switch")
                }
            }
            if lastTile == self.tile { continue }
            grid.ableTiles.append(lastTile)
        }
        for t in grid.ableTiles {
            t.isSpecialHighlighted = true
        }
    }
    
    override func specialAttack(toTile: Tile) {
        if self.isExausted {
            print("\(self.name!) is exausted")
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
                print("Actor::push(): prop didn't conform to any Element")
            }
        }
        guard let grid = GameManager.shared.grid else { return }
        if toTile.isWalkable {
            move(tile: toTile)
        } else if let target = toTile.character {
            // attacking a character
            switch grid.getDirection(from: self.tile, to: toTile) {
            case 0: // up
                move(tile: grid.getDownTile(tile: target.tile)!)
                push(character: target, to: grid.getUpTile(tile: target.tile))
            case 1: // down
                move(tile: grid.getUpTile(tile: target.tile)!)
                push(character: target, to: grid.getDownTile(tile: target.tile))
            case 2: // left
                move(tile: grid.getRightTile(tile: target.tile)!)
                push(character: target, to: grid.getLeftTile(tile: target.tile))
            case 3: // right
                move(tile: grid.getLeftTile(tile: target.tile)!)
                push(character: target, to: grid.getRightTile(tile: target.tile))
            default:
                return
            }
            target.takeDamage(damage: self.damage)
        }
        grid.removeHighlights()
        isExausted = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
