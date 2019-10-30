//
//  Character.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Actor: Entity {
    
    public private(set) var movement: Int
    public private(set) var movesLeft: Int
    public private(set) var damage: Int
    public private(set) var health: Int
    public private(set) var attackRange: Int
    internal var isExausted: Bool = false
    var breadcrumbs: [Tile] = [Tile]()
    private var stunned: Int = 0
    var wholeNumberValue: Float?
    var canMove: Bool = true
    
    init(name: String, movement: Int, damage: Int, health: Int, attackRange: Int, sprite: SKTexture, tile: Tile) {
        self.movement = movement
        self.movesLeft = movement
        self.damage = damage
        self.health = health
        self.attackRange = attackRange
        super.init(name: name, sprite: sprite, tile: tile)
        self.position = tile.position
        self.size = tile.size
        self.isUserInteractionEnabled = false
        tile.character = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage(damage: Int) {
        self.health -= damage
        if (self.health <= 0) {
            self.die()
        }
        HUD.updateHealthBars()
    }
    
    func die() {
        if let enemySelf = self as? Enemy {
            if let index = GameManager.shared.enemies.firstIndex(of: enemySelf) {
                GameManager.shared.enemies.remove(at: index)
            } else {
                print("Actor::die(): index of enemy returned nil")
            }
        } else {
            if let index = GameManager.shared.players.firstIndex(of: self) {
                GameManager.shared.players.remove(at: index)
            } else {
                print("Actor::die(): index of player returned nil")
            }
        }
        self.tile.character = nil
        self.removeFromParent()
    }
    
    func showMoveOptions() {
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        if self.movesLeft == 0 { return }
        let tiles = grid.getReachableTiles(fromTile: self.tile, moves: movesLeft)
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.highlightShader
        }
    }
    
    func move(tile: Tile) {
        self.tile.character = nil
        self.position = tile.position
        self.tile = tile
        tile.character = self
        self.movesLeft = 0 // TO-DO: substituir quando implementado o pathfinding (ir decrementando até chegar em zero)
    }
    
    func makeValidMove(tile: Tile?) -> Bool {
        guard let grid = GameManager.shared.grid else { return false }
        if tile == nil { return false }
        if !(grid.ableTiles.contains(tile!)) { return false }
        grid.removeHighlights()
        self.move(tile: tile!)
        return true
    }
    
    func basicAttack(target: Actor) -> Bool { return false }
    
    func specialAttack(tile: Tile) {}
       
    func showAttackOptions() {}
    
    func showSpecialAttackOptions() {}
    
    func stun(turns: Int) {
        movesLeft = 0
        isExausted = true
        self.stunned = turns
    }
    
    func beginTurn() {
        if stunned > 0 {
            stun(turns: self.stunned)
            self.stunned -= 1
        } else {
            self.movesLeft = movement
            self.isExausted = false
        }
    }
}
