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
        if self.isExausted { return }
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
    
    override func basicAttack(tile: Tile, completion: @escaping () -> Void) {
        GameManager.shared.scene.canoSound.run(SKAction.play())
        tile.character?.takeDamage(damage: self.damage)
        
        guard let grid = GameManager.shared.grid else { return }
        switch grid.getDirection(from: self.tile, to: tile) {
        case 0:
            tile.push(direction: 0, completion: {
                completion()
            })
        case 1:
            tile.push(direction: 1, completion: {
                completion()
            })
        case 2:
            tile.push(direction: 2, completion: {
                completion()
            })
        case 3:
            tile.push(direction: 3, completion: {
                completion()
            })
        default:
            print("Melee::basicAttack(): switch exausted!")
            return
        }
        isExausted = true
    }
    
    override func showSpecialAttackOptions() {
        if self.isExausted { return }
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
    
    override func specialAttack(tile: Tile, completion: @escaping () -> Void) {
        guard let grid = GameManager.shared.grid else { return }
        if tile.isWalkable {
            walk(tile: tile)
        } else if let target = tile.character {
            // attacking a character
            target.takeDamage(damage: self.damage)
            
            switch grid.getDirection(from: self.tile, to: tile) {
            case 0: // up
                walk(tile: grid.getDownTile(tile: target.tile)!)
                tile.push(direction: 0, completion: {
                    completion()
                })
            case 1: // down
                walk(tile: grid.getUpTile(tile: target.tile)!)
                tile.push(direction: 1, completion: {
                    completion()
                })
            case 2: // left
                walk(tile: grid.getRightTile(tile: target.tile)!)
                tile.push(direction: 2, completion: {
                    completion()
                })
            case 3: // right
                walk(tile: grid.getLeftTile(tile: target.tile)!)
                tile.push(direction: 3, completion: {
                    completion()
                })
            default:
                return
            }
        }
        grid.removeHighlights()
        isExausted = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
