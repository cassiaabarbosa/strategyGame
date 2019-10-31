//
//  Character.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Actor: Entity, Pushable {
    
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
        self.zPosition = 10
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
    
    private func die() {
        GameManager.shared.removeSelf(self)
    }
    
    func showMoveOptions() {
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        if self.movesLeft == 0 || self.isExausted { return }
        let tiles = grid.getReachableTiles(fromTile: self.tile, moves: movesLeft)
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.highlightShader
        }
    }
    
    private func move(tile: Tile) {
        self.tile.character = nil
        self.position = tile.position
        self.tile = tile
        tile.character = self
    }
    
    func walk(tile: Tile) {
        move(tile: tile)
        self.movesLeft = 0 // TODO: substituir quando implementado o pathfinding (ir decrementando até chegar em zero)
    }
    
    private func enterTile(entering: Tile, from sender: Tile) {
        if entering.isWalkable {
            self.move(tile: entering)
        } else if entering.character != nil {
            self.takeDamage(damage: 1)
            entering.character?.takeDamage(damage: 1)
            self.push(to: sender, from: entering)
        } else if entering.prop is Hole {
            self.move(tile: entering)
            GameManager.shared.scene.cairBuracoSound.run(SKAction.play())
            self.run(SKAction.scale(by: 0.2, duration: 2))
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                self.die()
            }
        } else if entering.prop is Mountain || entering.prop is Objective {
            self.takeDamage(damage: 1)
             self.push(to: sender, from: entering)
        } else if let trap = entering.prop as? Trap {
            self.move(tile: entering)
            trap.activateTrap(character: self)
        }
    }
    
    func push(to target: Tile, from sender: Tile) {
        self.enterTile(entering: target, from: sender)
    }
    
    func basicAttack(tile: Tile) {}
    
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
